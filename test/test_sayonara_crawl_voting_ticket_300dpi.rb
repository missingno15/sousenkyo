require "./minitest_helper"
require "sousenkyo/voting_ticket"
require "extensions/base_voting_ticket_test"

class TestSayonaraCrawlVotingTicket300DPI < Minitest::Test
  include BaseVotingTicketTest 

  private  

  def measurements_filepath
    "fixtures/measurements/sayonara_crawl.yml"
  end

  def ticket_path
    "images/crawl_300dpi.jpg"
  end

  def expected_width_in_px
    1369
  end

  def expected_height_in_px
    1389
  end

  def expected_upper_left_x
    0.4
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
