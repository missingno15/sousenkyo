module Sousenkyo
  class VoteProxy
    attr_reader :serial_codes, :browser

    def initialize(serial_codes, manifesto, browser_type = :chrome)
      @serial_codes = serial_codes
      @manifesto = manifesto
      @browser = Selenium::WebDriver.for browser_type
    end

    def vote!
      manifesto.each do |member|
        member.vote_count.times do
          serial_code = serial_codes.pop
          initiate_vote_process(serial_code, member) 
        end
      end
    end

    private

    attr_reader :serial_codes, :manifesto_file_path, :browser

    def initiate_vote_process(serial_code, member)
      browser.navigate.to("http://akb48-sousenkyo.jp/web/akb2015/vote/search_initial")
      browser.find_element(:id, "form_name").send_keys(member.jpname_with_space)
      browser.find_element(:id, "form_submit").click
      browser.find_element(:link_text, member.jpname_with_space).click
      browser.find_element(:id, "form_serialnum1").send_keys(serial_code.left_code)
      browser.find_element(:id, "form_serialnum2").send_keys(serial_code.right_code)
      browser.find_element(:xpath, "//input[@value='投票']").click
    end
  end
end
