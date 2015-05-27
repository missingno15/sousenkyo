module Sousenkyo
  class DimensionCalculator
    attr_reader :ticket

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

    def dpi
      @dpi ||= (short_side / ticket::WIDTH_IN_INCHES).round(-2)
    end

    def short_side
      [ticket.width_in_px, ticket.height_in_px].min
    end

    def 

    def calculate_x
      Constants["UPPER_LEFT_X"] * px_per_centimeter      
    end

    def calculate_y
      Constants["UPPER_LEFT_Y"] * px_per_centimeter      
    end

    def calculate_width
      Constants["SERIAL_CODE_WIDTH"] * px_per_centimeter      
    end

    def calculate_height
      Constants["SERIAL_CODE_HEIGHT"] * px_per_centimeter      
    end
  end
end
