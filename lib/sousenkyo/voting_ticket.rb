require 'rmagick'

module Sousenkyo
  class VotingTicket
    WIDTH_IN_CM  = Constant[:VOTING_TICKET_WIDTH]
    HEIGHT_IN_CM = Constant[:VOTING_TICKET_HEIGHT]

    attr_reader :filepath, 
                :image_scan, 
                :width_in_px, 
                :height_in_px

    attr_accessor :serial_code

    def initalize(filepath)
      @filepath     = filepath 
      @image_scan   = Magick::Image.read(filepath)[0]
      @width_in_px  = @image_scan.columns
      @height_in_px = @image_scan.rows
    end
  end
end
