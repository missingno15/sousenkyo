module Sousenkyo
  SerialCode = Struct.new(:serial_code) do
    def left_code
      serial_code.split(" ")[0]
    end

    def right_code
      serial_code.split(" ")[1]
    end
  end
end
