module Sousenkyo
  class VotingTicket
    class Factory
      def initialize(args)
        @voting_tickets_dir = args.fetch(
          :image_dirpath,
          "/Users/#{ENV["USER"]}/Desktop/voting_tickets"
        )
        @measurements = args[:measurements]
      end

      def create_tickets!
        image_scan_paths.map do |filepath|
          Sousenkyo::VotingTicket.new(filepath, measurements)
        end
      end

      private

      attr_reader :voting_tickets_dir, :measurements

      def image_scan_paths
        if tickets_directory.empty?
          raise Sousenkyo::Errors::EmptyDirectory
        elsif all_tickets.empty?
          raise Sousenkyo::Errors::TicketsNotDetected
        else
          all_tickets.map do |path| 
            File.expand_path(path)
          end
        end
      end

      def tickets_directory
        @tickets_directory ||= Dir["#{voting_tickets_dir}/*"]
      end

      def all_tickets
        tickets_directory.map do |file| 
          extension = File.extname(file)
          file if extension == ".jpg" || extension == ".png"
        end.compact
      end
    end
  end
end
