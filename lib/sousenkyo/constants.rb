require 'yaml'

module Sousenkyo
  class Constants
    CONSTANTS = YAML.load_file("../../config/constants.yml")

    def self.[](key)
      CONSTANTS[key]   
    end
  end
end
