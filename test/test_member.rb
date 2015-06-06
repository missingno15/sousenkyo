require_relative "minitest_helper"
require_relative "extensions/filepath_helper"
require "sousenkyo/member"
require "sousenkyo/manifesto"

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
        vote_count: 0,
        successful_vote_count: 0
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

  def test_that_vote_count_defaults_to_zero
    tani_marika = Sousenkyo::Member.new({    
      group: "SKE48",
      team: "Team E",
      jpname: "谷真理佳",
      jpname_with_space: "谷 真理佳",
      engname: "Tani Marika"
    })

    assert_equal(0, tani_marika.vote_count)
  end

  def test_that_successful_vote_count_defaults_to_zero
    yabuki_nako = Sousenkyo::Member.new({    
      group: "HKT48",
      team: "Team H",
      jpname: "矢吹奈子",
      jpname_with_space: "矢吹 奈子",
      engname: "Yabuki Nako"
    })

    assert_equal(0, yabuki_nako.successful_vote_count)
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

  def test_that_successful_vote_can_be_incremented
    suda_akari = Sousenkyo::Member.new({
      group: "SKE48",
      team: "Team E",
      jpname: "須田亜香里",
      jpname_with_space: "須田 亜香里",
      engname: "Suda Akari"
    })

    suda_akari.increment_successful_vote_count!  

    assert_equal(1, suda_akari.successful_vote_count)
  end

  def test_that_remaining_vote_count_will_give_correct_difference
    matsuoka_natsumi = Sousenkyo::Member.new({
      group: "HKT48",
      team: "Team H",
      jpname: "松岡菜摘",
      jpname_with_space: "松岡 菜摘",
      engname: "Matsuoka Natsumi"
    })

    matsuoka_natsumi.vote_count = 48
    
    46.times { matsuoka_natsumi.increment_successful_vote_count! }

    assert_equal(2, matsuoka_natsumi.remaining_vote_count)
  end

  def test_that_attributes_can_be_overidden
    tano_yuuka = Sousenkyo::Member.new({
      group: "AKB48",
      team: "Team K",
      jpname: "田野優花", 
      jpname_with_space: "田野 優花",
      engname: "Tano Yuka"
    })

    new_attributes = {
      group: "AKB48",
      team: "Team K",
      jpname: "田野優花", 
      jpname_with_space: "田野 優花",
      engname: "Tano Yuka",
      vote_count: 12,
      successful_vote_count: 2
    }

    tano_yuuka.attributes = new_attributes

    assert_equal(12, tano_yuuka.vote_count)
    assert_equal(2, tano_yuuka.successful_vote_count)
  end

  def test_that_only_hashes_can_be_accepted_for_attributes_setter_method
    paruru = Sousenkyo::Member.new({
      group: "AKB48",
      team: "Team A",
      jpname: "島崎遥香",
      jpname_with_space: "島崎 遥香",
      engname: "Shimazaki Haruka"
    })

    paruru.attributes = []
    assert_equal(Hash, paruru.attributes.class)
  end
end
