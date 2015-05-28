require_relative "minitest_helper"
require_relative "extensions/base_voting_ticket_test"
require "sousenkyo/voting_ticket"

class TestBokutachiWaTatakawanaiVotingTicket300DPI < Minitest::Test
  include BaseVotingTicketTest 

  private  

  def measurements_filepath
    File.expand_path("test/fixtures/measurements/bokutachi_wa_tatakawanai.yml")
  end

  def ticket_path
    "images/bokutachi_300dpi.jpg"
  end

  def expected_width_in_px
    1392
  end

  def expected_height_in_px
    1414
  end

  def expected_upper_left_x
    4.05
  end

  def expected_upper_left_y
    6.1
  end

  def expected_serial_code_width
    6.5
  end

  def expected_serial_code_height
    0.8
  end

  def expected_width_in_cm
    11.9
  end

  def expected_height_in_cm
    11.9
  end
end
