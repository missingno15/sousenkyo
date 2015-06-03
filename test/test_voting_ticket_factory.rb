require_relative "minitest_helper"
require_relative "extensions/filepath_helper"
require "sousenkyo/voting_ticket"
require "sousenkyo/voting_ticket/factory"
require "sousenkyo/errors/empty_directory"
require "sousenkyo/errors/tickets_not_detected"
require "yaml"
require "fileutils"

class TestVotingTicketFactory < Minitest::Test
  include FilepathHelper

  def setup
    @measurements ||= YAML.load_file(
      "#{fixtures_dirpath}/measurements/bokutachi_wa_tatakawanai.yml"
     )

     @desktop_dirpath ||= "/Users/#{ENV["USER"]}/Desktop/voting_tickets"
     @no_images_dirpath ||= "#{test_dirpath}/no_images"
     @empty_dirpath ||= "#{test_dirpath}/empty"

     FileUtils.rm_r(@no_images_dirpath) if Dir.exist?(@no_images_dirpath)
     FileUtils.rm_r(@empty_dirpath) if Dir.exist?(@empty_dirpath)
     FileUtils.rm_r(@desktop_dirpath) if Dir.exist?(@desktop_dirpath)

     FileUtils.mkdir(@desktop_dirpath)
     FileUtils.cp(Dir["#{test_dirpath}/images/bokutachi/*"], @desktop_dirpath)

     FileUtils.mkdir(@no_images_dirpath)
     FileUtils.mkdir(@empty_dirpath)
     FileUtils.touch([
       "#{@no_images_dirpath}/test.txt", 
       "#{@no_images_dirpath}/test.rb"
     ])

    @default_factory ||= Sousenkyo::VotingTicket::Factory.new({
      measurements: @measurements
    })

    @empty_factory ||= Sousenkyo::VotingTicket::Factory.new({
      image_dirpath: @empty_dirpath,
      measurements: @measurements
    })

    @specific_factory ||= Sousenkyo::VotingTicket::Factory.new({
      image_dirpath: "#{test_dirpath}/images/bokutachi/",
      measurements: @measurements
    })
  end

  def teardown
    FileUtils.rm_r(@no_images_dirpath) if Dir.exist?(@no_images_dirpath)
    FileUtils.rm_r(@empty_dirpath) if Dir.exist?(@empty_dirpath)
    FileUtils.rm_r(@desktop_dirpath) if Dir.exist?(@desktop_dirpath)
  end

  def test_that_default_factory_gives_correct_number_of_tickets
    tickets = @default_factory.create_tickets!
    assert_equal(4, tickets.size)
  end

  def test_that_default_factory_outputs_voting_tickets
    tickets = @default_factory.create_tickets!

    that_they_are_all_voting_tickets = tickets.all? do |ticket| 
      ticket.class == Sousenkyo::VotingTicket
    end

    assert(that_they_are_all_voting_tickets)
  end

  def test_that_specific_factory_gives_correct_number_of_tickets
    tickets = @specific_factory.create_tickets!
    assert_equal(4, tickets.size)
  end

  def test_that_default_factory_outputs_voting_tickets
    tickets = @specific_factory.create_tickets!

    that_they_are_all_voting_tickets = tickets.all? do |ticket| 
      ticket.class == Sousenkyo::VotingTicket
    end

    assert(that_they_are_all_voting_tickets)
  end

  def test_that_empty_directory_raises_an_error_when_dir_is_empty
    assert_raises(Sousenkyo::Errors::EmptyDirectory) do 
      @empty_factory.create_tickets!
    end
  end

  def test_that_empty_directory_raise_an_error_when_no_images_are_found
    no_images_factory = Sousenkyo::VotingTicket::Factory.new({
      image_dirpath: @no_images_dirpath,
      measurements: @measurements
    })
    assert_raises(Sousenkyo::Errors::TicketsNotDetected) do
      no_images_factory.create_tickets!
    end
  end
end
