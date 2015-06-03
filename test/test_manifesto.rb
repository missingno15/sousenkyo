require_relative "./minitest_helper"
require_relative "extensions/filepath_helper"

require "sousenkyo/manifesto"
require "sousenkyo/member"
require "sousenkyo/errors/member_not_found"
require "fileutils"

class TestManifesto < Minitest::Test
  include FilepathHelper

  attr_reader :test_manifesto_path, :manifesto

  def setup
    @test_manifesto_path = "#{test_dirpath}/fixtures/manifesto.yml"
    FileUtils.rm(test_manifesto_path) if File.exists?(test_manifesto_path)

    @manifesto = Sousenkyo::Manifesto.new({
      manifesto_path: test_manifesto_path,
    })
  end

  def teardown
    FileUtils.rm(test_manifesto_path) if File.exists?(test_manifesto_path)
  end

  def test_that_it_adds_a_member_to_the_manifesto
    tashima_meru = Sousenkyo::Member.find_by({jpname: "田島芽瑠"})
    tashima_meru.vote_count = 4
    manifesto.add(tashima_meru)

    assert_equal(1, test_manifesto.count)
  end

  def test_that_it_enforces_unique_count
    shinobu_mogi = Sousenkyo::Member.find_by({jpname: "茂木忍"})
    shinobu_mogi.vote_count = 4 
    manifesto.add(shinobu_mogi)
    shinobu_mogi.vote_count = 8
    manifesto.add(shinobu_mogi)

    assert_equal(1, test_manifesto.size)
  end

  def test_that_it_enforces_unique_object
    shinobu_mogi = Sousenkyo::Member.find_by({jpname: "茂木忍"})
    shinobu_mogi.vote_count = 4 
    manifesto.add(shinobu_mogi)
    shinobu_mogi.vote_count = 8
    manifesto.add(shinobu_mogi)

    assert_equal(nil, test_manifesto[1])
    assert_equal(4, test_manifesto[0][:vote_count])
  end

  def test_that_it_edits_a_vote_count_of_a_member
    sasaki_yukari = Sousenkyo::Member.find_by({jpname: "佐々木優佳里"})
    sasaki_yukari.vote_count = 2
    manifesto.add(sasaki_yukari)
    sasaki_yukari.vote_count = 6
    manifesto.edit_vote_count(sasaki_yukari)

    assert_equal(6, test_manifesto[0][:vote_count])
  end

  def test_that_it_deletes_an_existing_member
    kobayashi_marina = Sousenkyo::Member.find_by({jpname: "小林茉里奈"}) 
    kobayashi_marina.vote_count = 5
    manifesto.add(kobayashi_marina)
    manifesto.delete(kobayashi_marina)

    assert_equal([], test_manifesto)
  end

  def test_that_it_doesnt_delete_a_member_that_doesnt_exist
    kato_rena = Sousenkyo::Member.find_by({jpname: "加藤玲奈"})    
    kato_rena.vote_count = 4
    manifesto.add(kato_rena)
    manifesto.delete(kato_rena)
    manifesto.delete(kato_rena)

    assert_equal([], test_manifesto)
  end

  private

  def test_manifesto
    YAML.load_file(test_manifesto_path)
  end
end
