require "bundler/gem_tasks"
require "rake/testtask"

task :console do
  exec "irb -r sousenkyo -I ./lib"
end

Rake::TestTask.new do |t|
  t.pattern = "test/test_*.rb"
end
