module Sousenkyo
  class CLISuite < Thor
    desc "sousenkyo vote", "Activate the entire process"
    long_desc <<-VOTE
    
    `sousenkyo vote` will run the entire process from taking the
    scanned voting ticket images, extracting the serial codes, 
    and then running them through Selenium to vote for the members
    of your choice. Before running `sousenkyo vote`, make sure to
    run `sousenkyo add MEMBER VOTE_COUNT`.
    VOTE
    def vote
      manifesto = Manifesto.new
      tickets   = VotingTicketFactory.new(
        settings: YAML.load_file(Sousenkyo.config_path("settings.yml")),
        measurements: YAML.load_file(Sousenkyo.config_path("measurements.yml"))
      ).create_tickets!

      serial_codes = VotingTicketOCR.new(tickets).parse_serial_codes

      VotingProxy.new(
        serial_codes,
        manifesto.filepath  
      ).vote!
    end

    def add(name, count)
      manifesto = Manifesto.new
      manifesto.add(Member.new(name, count))
    end

    def edit(name, count)
      manifesto = Manifesto.new
      manifesto.edit(Member.new(name, count))
    end

    def delete(name, count)
      manifesto = Manifesto.new
      manifesto.delete(Member.new(name, count))
    end

    def manifesto
      manifesto = Manifesto.new
      manifesto.list
    end
  end
end
