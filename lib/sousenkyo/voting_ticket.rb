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
      @filepath     = filepath
      @image_scan   = Magick::Image.read(@filepath)[0]
      @width_in_px  = @image_scan.columns
      @height_in_px = @image_scan.rows
      @upper_left_x = measurements[:upper_left_x]
      @upper_left_y = measurements[:upper_left_y]
      @serial_code_width = measurements[:serial_code_width]
      @serial_code_height = measurements[:serial_code_height]
      @width_in_cm = measurements[:width_in_cm]
      @height_in_cm = measurements[:height_in_cm]
    end
  end
end
