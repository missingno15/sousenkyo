module Sousenkyo
  class DimensionCalculator
    attr_reader :ticket, 

    def initialize(ticket)
      @ticket = ticket
    end
    
    def serial_code_area
      {
        x: calculate_x,
        y: calcuate_y,
        width: calculate_width,
        height: calculate_height
      }
    end

    private

    def px_per_centimeter
      @px_per_centimeter ||= begin
        short_side = [
          ticket.width_in_px, 
          ticket.height_in_px
        ].min

        (short_side / ticket::WIDTH_IN_CM).round(-2)
      end
    end

    def calculate_x
      Constant[:UPPER_LEFT_X] * px_per_centimeter      
    end

    def calculate_y
      Constant[:UPPER_LEFT_Y] * px_per_centimeter      
    end

    def calculate_width
      Constant[:SERIAL_CODE_WIDTH] * px_per_centimeter      
    end

    def calculate_height
      Constant[:SERIAL_CODE_HEIGHT] * px_per_centimeter      
    end
  end
end
