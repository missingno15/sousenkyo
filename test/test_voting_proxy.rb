require "./minitest_helper"
require "sousenkyo/voting_proxy"

class TestVotingProxy < Minitest::Test
  attr_reader :valid_voting_proxy,
              :invalid_voting_proxy
  def setup
    serial_codes = [["dd289zfe", "f2euqv6b"]]
    @valid_voting_proxy = Sousenkyo::VotingProxy.new(serial_codes)
  end

  def teardown
    valid_voting_proxy.quit
  end

  def test_it_raises_year_mismatch_code_error
    valid_voting_proxy.vote!
    html = valid_voting_proxy.page_source
    assert_match(
      /too short length/,
      html
    )
  end

  def test_it_raises_already_used_code_error
    skip
  end

  def test_it_raises_length_too_short_error
    skip
  end
end
