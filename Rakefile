require "rake/testtask"
require "bundler/gem_tasks"

task :default => :test

Rake::TestTask.new do |t|
  t.ruby_opts = [ '-rminitest/autorun', '-rminitest/pride', '-rlatinverb_type_evaluator' ]
  t.libs << "test"
  t.test_files = FileList['test/*test*.rb']
  t.verbose = true
end

