require "yaml"
require "rtesseract"
require "rmagick"
require "selenium-webdriver"

require "sousenkyo/version"

module Sousenkyo
  def self.config_path(filename = "")
    File.join(Sousenkyo.root, "config", filename)
  end

  def self.locale=(locale)
    @locale = locale
  end

  def self.locale
    @locale
  end

  def self.root
    File.dirname __dir__
  end
end
