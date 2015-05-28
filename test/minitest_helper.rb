$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
$LOAD_PATH.unshift File.expand_path('./')
require "sousenkyo"

require "minitest/autorun"
require "minitest/reporters"
require "pry"

Minitest::Reporters.use! [Minitest::Reporters::DefaultReporter.new(color: true)]
