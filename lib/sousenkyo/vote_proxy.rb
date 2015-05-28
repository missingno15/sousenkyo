module Sousenkyo
  class VoteProxy
    def initialize(serial_codes, manifesto_file_path, browser_type = :chrome)
      @serial_codes = serial_codes
      @browser = Selenium::WebDriver.for browser_type
    end

    private

    attr_reader :serial_codes, :manifesto_file_path, :browser
  end
end
