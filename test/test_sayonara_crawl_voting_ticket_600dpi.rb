require_relative "minitest_helper"
require_relative "extensions/base_voting_ticket_test"
require "sousenkyo/voting_ticket"

class TestSayonaraCrawlVotingTicket600DPI < Minitest::Test
  include BaseVotingTicketTest 

  private  

  def measurements_filepath
    File.expand_path("test/fixtures/measurements/sayonara_crawl.yml")
  end

  def ticket_path
    "images/crawl_600dpi.jpg"
  end

  def expected_width_in_px
    2765
  end

  def expected_height_in_px
    2768
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
