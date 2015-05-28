require_relative "minitest_helper"
require "sousenkyo/serial_code"

class TestSerialCode < Minitest::Test
  def setup
    @serial_code = Sousenkyo::SerialCode.new("5aufaze3 nwrp56jp")
  end

  def test_serial_code
    assert_equal "5aufaze3 nwrp56jp", @serial_code.serial_code
  end

  def test_left_code
    assert_equal "5aufaze3", @serial_code.left_code
  end

  def test_right_code
    assert_equal "nwrp56jp", @serial_code.right_code
  end
end
