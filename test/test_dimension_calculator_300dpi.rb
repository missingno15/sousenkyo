require_relative "./minitest_helper"
require_relative "extensions/filepath_helper"
require "sousenkyo/voting_ticket"
require "sousenkyo/dimension_calculator"

require "yaml"
require "pry"

class TestDimensionCalculator300DPI < Minitest::Test
  include FilepathHelper

  attr_reader :dc, :delta

  def setup
    @delta = 0.005
    ticket = Sousenkyo::VotingTicket.new(
      "#{images_dirpath}/bokutachi_300dpi.jpg",
      YAML.load_file("#{fixtures_dirpath}/measurements/bokutachi_wa_tatakawanai.yml")
    ) 
    @dc ||= Sousenkyo::DimensionCalculator.new(ticket)
  end
  
  def test_calculate_x
    assert_in_delta(
      476.952,
      dc.serial_code_area[:x],
      delta
    )
  end

  def test_calculate_y
    assert_in_delta(
      718.372,
      dc.serial_code_area[:y],
      delta
    )
  end

  def test_calculate_width
    assert_in_delta(
      765.479,
      dc.serial_code_area[:width],
      delta
    )
  end

  def test_calculate_height
    assert_in_delta(
      94.212,
      dc.serial_code_area[:height],
      delta
    )
  end
end
