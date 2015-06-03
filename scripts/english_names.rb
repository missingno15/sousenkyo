require 'nokogiri'
require 'httparty'
require 'yaml'
require 'pry'


BASE_URL = "http://stage48.net/wiki/index.php"

roster = YAML.load_file("superroster.yml")

roster.each_with_index do |member, i|
  page = Nokogiri::HTML(
    HTTParty.get(
      "http://stage48.net/wiki/index.php",
      query: {
        "search" => member[:jpname],
        "go" => "Go",
        "title" => "Special:Search"
      }
    )
  )

  begin
    english_name = page.at(".mw-search-results .mw-search-result-heading a").text
    puts english_name
    member[:engname] = english_name
  rescue
    puts "Couldn't find name in English"
    member[:engname] = "not_found"
  end
end

File.write("wonderful_roster.yml", roster.to_yaml)

binding.pry
