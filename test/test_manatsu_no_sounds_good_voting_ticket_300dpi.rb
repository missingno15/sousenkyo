require_relative "minitest_helper"
require_relative "extensions/base_voting_ticket_test"
require "sousenkyo/voting_ticket"

class TestManatsuNoSoundsGoodVotingTicket300DPI < Minitest::Test
  include BaseVotingTicketTest 

  private  

  def measurements_filepath
    "#{File.dirname(__FILE__)}/fixtures/measurements/manatsu_no_sounds_good.yml"
  end

  def ticket_path
    "images/manatsu_300dpi.jpg"
  end

  def expected_width_in_px
    1385
  end

  def expected_height_in_px
    1379
  end

  def expected_upper_left_x
    1.2
  end

  def expected_upper_left_y
    5.5
  end

  def expected_serial_code_width
    6.5
  end

  def expected_serial_code_height
    0.7
  end

  def expected_width_in_cm
    11.8
  end

  def expected_height_in_cm
    11.8
  end
end
