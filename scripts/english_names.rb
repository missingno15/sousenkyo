require 'nokogiri'
require 'httparty'
require 'yaml'
require 'pry'


BASE_URL = "http://stage48.net/wiki/index.php"

group = YAML.load_file("roster.yml")

group.each do |group|
  teams = group[1]
  keys = teams.keys

  keys.each do |key|
    members = teams[key]

    members.each_with_index do |member, i|
      page = Nokogiri::HTML(
        HTTParty.get(
          "http://stage48.net/wiki/index.php",
          query: {
            "search" => member[:jp_name],
            "go" => "Go",
            "title" => "Special:Search"
          }
        )
      )

      begin
        english_name = page.at(".mw-search-results .mw-search-result-heading a").text
        puts english_name
        member[:eng_name] = english_name
        members[i] = member 
      rescue
        puts "Couldn't find name in English"
        member[:eng_name] = "not_found"
        members[i] = member
      end
    end
  end
end

binding.pry
