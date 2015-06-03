module Sousenkyo
  SerialCode = Struct.new(:serial_code) do
    def left_code
      split_code[0]
    end

    def right_code
      split_code[1]
    end

    private

    def split_code
      @split_code ||= serial_code.split(" ")
    end
  end
end
