$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require "sousenkyo"

require "minitest/autorun"
require "minitest/reporters"
require "pry"
Dir["extensions/*"].each { |ext| require ext }

Minitest::Reporters.use! [Minitest::Reporters::DefaultReporter.new(color: true)]
