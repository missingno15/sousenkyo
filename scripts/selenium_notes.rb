# testing out selenium

require 'selenium-webdriver'
require "pry"

browser = Selenium::WebDriver.for :chrome

browser.navigate.to("http://akb48-sousenkyo.jp/web/akb2015/vote/search_initial")

# When performing a search, there must be a space between their
# last and first name
browser.find_element(:id, "form_name").send_keys("沖田 彩華")

browser.find_element(:id, "form_submit").click

browser.find_element(:link_text, "沖田 彩華").click

browser.find_element(:id, "form_serialnum1").send_keys("code 1")

browser.find_element(:id, "form_serialnum2").send_keys("code 2")

browser.find_element(:xpath, "//input[@value='投票']").click

# def fill_in(attr, identifier, content)
# end


binding.pry
