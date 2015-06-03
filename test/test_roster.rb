require_relative "./minitest_helper"
require_relative "extensions/filepath_helper"

require "sousenkyo/roster"

class TestRoster < Minitest::Test
  include FilepathHelper  

  attr_reader :roster

  def setup
    @roster = Sousenkyo::Roster.new({roster_filepath: "#{fixtures_dirpath}/roster/roster2015.yml"})
  end

  def test_that_it_returns_all_members_across_all_groups  
    assert_equal(
      YAML.load_file("#{fixtures_dirpath}/roster/members.yml"), 
      roster.all_members 
    )
  end
end
