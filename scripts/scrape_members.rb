require 'pry'
require 'yaml'
require 'nokogiri'
require 'httparty'

GROUPS = [
  "AKB48",
  "SKE48",
  "NMB48",
  "HKT48",
  "SNH48"#,
  #"NGT48"
]
BASE_URL = "http://sousenkyo.akb48.co.jp/member.php"

def get_group_page(group)
  Nokogiri::HTML(
    HTTParty.get(
      BASE_URL,
      query: { "group" => group }
    ).body
  )
end

roster = {}

GROUPS.each do |group|
  members_page = get_group_page(group)
  roster[group.to_sym] = {}
  
  (1..5).to_a.each do |n|
    team_area = members_page.at("#team_#{n}")

    next if team_area.nil?

    team_name = team_area.at("h3").text.strip.gsub(/\s/, "")
    members = team_area.css(".ml_name").map do |name| 
      {
        jp_name: name.text.strip.gsub(/\s/, ""),
        jp_name_with_space: name.text.strip,
        eng_name: ""
      }
    end

    puts team_name
    members.each { |member| puts "\t" + member[:jp_name] }

    roster[group.to_sym][team_name.to_sym] = members
  end
end

File.write("roster.yml", roster.to_yaml)
