module Sousenkyo
  SerialCode = Struct.new(:serial_code) do
    def split_code
      @split_code ||= serial_code.split(" ")
    end
   
    def left_code
      split_code[0]
    end

    def right_code
      split_code[1]
    end
  end
end
