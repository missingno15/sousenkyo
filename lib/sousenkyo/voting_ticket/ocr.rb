module Sousenkyo
  class VotingTicket
    class OCR
      def initialize(tickets)
        @tickets = tickets
      end

      def parse_serial_codes
        tickets.map do |ticket|
          dc    = DimensionCalulator.new(ticket)
          image = RTesseract::Mixed.new(
            ticket.filepath,
            { areas: [ dc.serial_code_area ] }
          )

          serial_code = image.to_s[/[a-z1-9]{8}\s[a-z1-9]{8}/]
          SerialCode.new(serial_code)
        end
      end
    end
  end
end
