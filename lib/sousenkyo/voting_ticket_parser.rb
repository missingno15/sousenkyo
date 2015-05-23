require 'rtesseract'

module Sousenkyo
  class VotingTicketParser
    def initialize(tickets)
      @tickets = tickets
    end

    def parse_serial_codes
      ticket.map do |ticket|
        dc    = DimensionCalulator.new(ticket)
        image = RTesseract::Mixed.new(
          ticket.filepath,
          { areas: [ dc.serial_code_area ] }
        )

        ticket.serial_code = image.to_s.strip
        ticket
      end
    end
  end
end
