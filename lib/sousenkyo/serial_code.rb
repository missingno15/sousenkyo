module Sousenkyo
  class SerialCode
    attr_reader :serial_code

    def initialize(serial_code)
      @serial_code = serial_code
      @vote_successful = nil
    end

    def left_code
      split_code[0]
    end

    def right_code
      split_code[1]
    end

    def mark_as_used!
      #to be implemented
    end

    def mark_as_failed!
      #to be implemented
    end

    private

    def split_code
      @split_code ||= serial_code.split(" ")
    end
  end
end
