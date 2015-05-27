require "selenium-webdriver"

module Sousenkyo
  class VotingProxy
    attr_reader :serial_codes
    def initialize(serial_codes)
      @serial_codes = serial_codes
      @browser = Selenium::WebDriver.for Settings.browser
    end
  end
end
