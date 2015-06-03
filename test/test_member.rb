require_relative "minitest_helper"
require_relative "extensions/filepath_helper"
require "sousenkyo/member"

class TestMember < Minitest::Test
  include FilepathHelper

  def test_that_it_returns_entire_roster_with_member_objects
    roster = YAML.load_file(Sousenkyo.config_path("roster2015.yml")).map do |member|
      Sousenkyo::Member.new(member)
    end
    assert_equal(
      roster.count,
      Sousenkyo::Member.all.count
    )
  end

  def test_that_it_returns_attributes_as_a_hash
    mukaichi_mion = Sousenkyo::Member.new({
      group: "AKB48",
      team: "Team 4",
      jpname: "向井地美音",
      jpname_with_space: "向井地 美音",
      engname: "Mukaichi Mion"
    })
    
    assert_equal(
      {
        group: "AKB48",
        team: "Team 4",
        jpname: "向井地美音",
        jpname_with_space: "向井地 美音",
        engname: "Mukaichi Mion",
        vote_count: nil
      },
      mukaichi_mion.attributes
    )
  end

  def test_that_returns_all_members_of_a_certain_condition
    assert_equal(
      YAML.load_file("#{fixtures_dirpath}/roster/ske48.yml").count,
      Sousenkyo::Member.where({group: "SKE48"}).count
    )
  end

  def test_that_it_returns_an_empty_array_if_all_members_dont_have_condition
    assert_equal(
      [],
      Sousenkyo::Member.where({group: "WHY@DOLL"})
    )
  end

  def test_that_it_gets_finds_specific_member
    tanaka_miku = Sousenkyo::Member.new({
      group: "HKT48",
      team: "Team H",
      jpname: "田中美久",
      jpname_with_space: "田中 美久",
      engname: "Tanaka Miku"
    })

    assert_equal(
      tanaka_miku.attributes,
      Sousenkyo::Member.find_by({jpname: "田中美久"}).attributes
    )
  end

  def test_that_it_returns_nil_if_specific_member_is_not_found_in_roster
    assert_equal(
      nil,
      Sousenkyo::Member.find_by({jpname: "渡辺亜紗美"})
    )
  end

  def test_that_vote_count_can_be_edited
    kato_rena = Sousenkyo::Member.new({
      group: "AKB48",
      team: "Team 4",
      jpname: "加藤玲奈",
      jpname_with_space: "加藤 玲奈",
      engname: "Kato Rena"
    })

    kato_rena.vote_count = 9001

    assert_equal(
      9001,
      kato_rena.vote_count
    )
  end
end
