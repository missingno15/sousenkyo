require "yaml"
require "rtesseract"
require "rmagick"
require "selenium-webdriver"

require "sousenkyo/version"

module Sousenkyo
  def self.root
    File.dirname __dir__
  end

  def self.config_path(filename)
    File.join(Sousenkyo.root, "config", filename)
  end
end
