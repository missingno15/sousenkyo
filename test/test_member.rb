require_relative "minitest_helper"
require "sousenkyo/member"

class TestMember < Minitest::Test
  def setup
    @member = Sousenkyo::Member.new("岸野里香", 3)
  end

  def test_name
    assert_equal "岸野里香", @member.name
  end

  def test_vote_count
    assert_equal 3, @member.vote_count
  end
end
