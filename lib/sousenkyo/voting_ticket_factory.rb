class VotingTicketFactory
  attr_reader :voting_tickets_dir, :measurements

  def initialize(args)
    @voting_tickets_dir = args.fetch(
      :image_dir_path,
      "/Users/#{ENV["USER"]}/Desktop/voting_tickets"
    )
    @measurements = args[:measurements]
  end

  def create_tickets!
    image_scan_paths.map do |filepath|
      VotingTicket.new(filepath, measurements)
    end
  end

  private

  def image_scan_paths
    if tickets_directory.empty?
      raise TicketsNotFound
    else
      tickets_directory.map do |path| 
        File.expand_path(path)
      end
    end
  end

  def tickets_directory
    @tickets_directory ||= Dir["#{voting_tickets_dir}*"]
  end
end
