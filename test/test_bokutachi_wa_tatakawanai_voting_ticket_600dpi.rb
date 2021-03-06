require_relative "minitest_helper"
require_relative "extensions/base_voting_ticket_test"
require_relative "extensions/filepath_helper"
require "sousenkyo/voting_ticket"

class TestBokutachiWaTatakawanaiVotingTicket600DPI < Minitest::Test
  include BaseVotingTicketTest 
  include FilepathHelper 

  private  

  def measurements_filepath
    "#{fixtures_dirpath}/measurements/bokutachi_wa_tatakawanai.yml"
  end

  def ticket_path
    "images/bokutachi_600dpi.jpg"
  end

  def expected_width_in_px
    2760
  end

  def expected_height_in_px
    2779
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
    11.82
  end

  def expected_height_in_cm
    11.815
  end
end
