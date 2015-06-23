module Sousenkyo
  class VoteProxy
    def initialize(serial_codes, manifesto, browser_type)
      @serial_codes = serial_codes
      @manifesto = manifesto
      @browser = Selenium::WebDriver.for browser_type
    end

    def vote!
      manifesto.list.each do |member|
        member.remaining_vote_count.times do
          serial_code = serial_codes.pop
          initiate_vote_process(serial_code, member) 

          sleep(rand(3))
        end
      end
    end

    private

    attr_reader :serial_codes, :manifesto, :browser

    def initiate_vote_process(serial_code, member)
      browser.navigate.to("http://akb48-sousenkyo.jp/web/akb2015/vote/search_initial")
      browser.find_element(:id, "form_name").send_keys(member.jpname_with_space)
      browser.find_element(:id, "form_submit").click
      browser.find_element(:link_text, member.jpname_with_space).click
      browser.find_element(:id, "form_serialnum1").send_keys(serial_code.left_code)
      browser.find_element(:id, "form_serialnum2").send_keys(serial_code.right_code)
      browser.find_element(:xpath, "//input[@value='投票']").click

      metadata = {
        time: Time.now.strftime("%F %H:%M:%S.%L"),
        serial_code: serial_code.number,
        member: member.name
      }

      case browser.page_source
      when /シリアルナンバーは入力必須です/
        Il8n.t("voting.errors.empty", metadata)
      when /シリアルナンバーは8桁ずつ入力してください/
        Il8n.t("voting.errors.length", metadata)
      when /入力されたシリアルナンバーは無効であるか既に投票済みです/
        Il8n.t("voting.errors.void", metadata)
      when /ご投票頂きありがとうございました/
        Il8n.t("voting.success", metadata)
        manifesto.edit(member.increment_successful_vote!)
      else
        raise Sousenkyo::Errors::UnidentifiedMessage
      end
    end
  end
end
