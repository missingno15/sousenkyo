require_relative 'minitest_helper'

class TestSousenkyo < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Sousenkyo::VERSION
  end
end
