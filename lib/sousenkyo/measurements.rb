module Sousenkyo
  class Measurements
    attr_reader :measurements

    def initialize(args)
      @measurements = YAML.load_file(
        args.fetch(
          :measurements_filepath, 
          Sousenkyo.config_path("measurements.yml")
        )
      )
    end

    def upper_left_x
      measurements["UPPER_LEFT_X"]
    end

    def upper_left_y
      measurements["UPPER_LEFT_Y"]
    end

    def serial_code_width
      measurements["SERIAL_CODE_WIDTH"]
    end

    def serial_code_height
      measurements["SERIAL_CODE_HEIGHT"]
    end
  end
end
