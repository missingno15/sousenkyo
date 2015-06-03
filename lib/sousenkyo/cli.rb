module Sousenkyo
  class CLISuite < Thor
    attr_reader :settings, :manifesto

    def initialize
      super
      @settings = YAML.load_file(Sousenkyo.config_path("settings.yml"))
      @manifesto = Manifesto.new({ manifesto: settings[:manifesto_path] })
    end

    desc "sousenkyo vote", "Activate the entire process"
    long_desc <<-VOTE
    
    `sousenkyo vote` will run the entire process from taking the
    scanned voting ticket images, extracting the serial codes, 
    and then running them through Selenium to vote for the members
    of your choice. Before running `sousenkyo vote`, make sure to
    run `sousenkyo add MEMBER VOTE_COUNT`.
    VOTE

    def vote
      tickets = VotingTicketFactory.new(
        image_dirpath: settings["image_dirpath"],
        measurements: YAML.load_file(Sousenkyo.config_path("measurements.yml"))
      ).create_tickets!

      serial_codes = VotingTicketOCR.new(tickets).parse_serial_codes

      VoteProxy.new(
        serial_codes,
        manifesto
      ).vote!
    end

    def add(name, count)
      member = Member.find_by({ jpname: name})
      member.vote_count = count
      manifesto.add(member)
    end

    def edit(name, count)
      member = Member.find_by({ jpname: name})
      member.vote_count = count
      manifesto.edit(member)
    end

    def delete(name)
      member = Member.find_by({ jpname: name})
      manifesto.delete(member)
    end

    def manifesto
      manifesto.list
    end
  end
end
