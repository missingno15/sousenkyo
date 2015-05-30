require_relative "./minitest_helper"
require_relative "extensions/filepath_helper"
require "sousenkyo/voting_ticket"
require "sousenkyo/dimension_calculator"

require "yaml"

class TestDimensionCalculator600DPI < Minitest::Test
  include FilepathHelper

  attr_reader :dc, :delta

  def setup
    @delta = 0.005
    ticket = Sousenkyo::VotingTicket.new(
      "#{images_dirpath}/bokutachi_600dpi.jpg",
      YAML.load_file("#{fixtures_dirpath}/measurements/bokutachi_wa_tatakawanai.yml")
    ) 
    @dc ||= Sousenkyo::DimensionCalculator.new(ticket)
  end
  
  def test_calculate_x
    assert_in_delta(
      945.685,
      dc.serial_code_area[:x],
      delta
    )
  end

  def test_calculate_y
    assert_in_delta(
      1424.362,
      dc.serial_code_area[:y],
      delta
    )
  end

  def test_calculate_width
    assert_in_delta(
      1517.763,
      dc.serial_code_area[:width],
      delta
    )
  end

  def test_calculate_height
    assert_in_delta(
      186.801,
      dc.serial_code_area[:height],
      delta
    )
  end
end
