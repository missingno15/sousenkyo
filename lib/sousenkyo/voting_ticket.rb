module Sousenkyo
  class VotingTicket
    attr_reader :filepath, 
                :image_scan, 
                :width_in_px, 
                :height_in_px,
                :upper_left_x,
                :upper_left_y,
                :serial_code_width,
                :serial_code_height,
                :width_in_cm,
                :height_in_cm

    def initialize(filepath, measurements)
      @filepath     = args[:filepath]
      @image_scan   = Magick::Image.read(@filepath)[0]
      @width_in_px  = @image_scan.columns
      @height_in_px = @image_scan.rows
      @upper_left_x = args[:upper_left_x ]
      @upper_left_y = args[:upper_left_y]
      @serial_code_width = args[:serial_code_width]
      @serial_code_height = args[:serial_code_height]
      @width_in_cm = args[:width_in_cm]
      @height_in_cm = args[:height_in_cm]
    end
  end
end
