require_relative "./minitest_helper"
require_relative "extensions/filepath_helper"
require "sousenkyo/voting_ticket"
require "sousenkyo/dimension_calculator"
require "sousenkyo/voting_ticket/ocr"
require "sousenkyo/voting_ticket/factory"
require "sousenkyo/serial_code"

class TestVotingTicketOcr < Minitest::Test
  include FilepathHelper

  attr_reader :ocr, :serial_codes

  def setup
    tickets = Sousenkyo::VotingTicket::Factory.new({
      image_dirpath: "#{images_dirpath}/bokutachi",
      measurements: YAML.load_file("#{fixtures_dirpath}/measurements/bokutachi_wa_tatakawanai.yml")
    }).create_tickets!

    @ocr ||= Sousenkyo::VotingTicket::OCR.new(tickets)
    @serial_codes ||= @ocr.parse_serial_codes.map do |serial_code| 
      serial_code.serial_code
    end
  end

  def test_that_it_returns_wm8si255_ads7xsc7
    assert_includes(serial_codes, "wm8si255 ads7xsc7")
  end

  def test_that_it_returns_ms8zhn84_aripu7f7
    assert_includes(serial_codes, "ms8zhn84 aripu7f7")
  end

  def test_that_it_returns_5aufaze3_nwrp56jp
    assert_includes(serial_codes, "5aufaze3 nwrp56jp")
  end

  def test_that_it_returns_idm76743_7c8sirt2
    assert_includes(serial_codes, "idm76743 7c8sirt2")
  end
end
