require "./minitest_helper"
require "sousenkyo/voting_ticket"

class TestSayonaraCrawlVotingTicket < Minitest::Test
  include ErrorMessages

  def setup
    measurements = YAML.load_file("fixtures/sayonara_crawl_measurements.yml")
    @sayonara_crawl_voting_ticket = Souenkyo::VotingTicket.new(
      {
        filepath: "fixtures/sayonara_crawl.png",
        image_scan: Magick::Image.read("fixtures/sayonara_crawl.png")[0],
        upper_left_x: measurements["UPPER_LEFT_X"],
        upper_left_y: measurements["UPPER_LEFT_Y"],
        serial_code_width: measurements["SERIAL_CODE_WIDTH"],
        serial_code_height: measurements["SERIAL_CODE_HEIGHT"]
      }
    )
  end

  def test_filepath_method
    test_image_filepath = File.join(
      Sousenkyo.root,
      "test",
      "fixtures",
      "sayonara_crawl.png"
      )
    assert_equal(
      test_image_filepath,
      @sayonara_crawl_voting_ticket.filepath,
      error_message(
        test_image_filepath,
        @sayonara_crawl_voting_ticket.filepath,
      )
    )
  end

  def test_serial_code
    assert_equal(
      "dd289zfe f2euqv6b"
    )
  end


end
