require 'cucumber/rake/task'
require 'rspec/core/rake_task'

desc 'Run my cucumber'
task :cucumber do
  Cucumber::Rake::Task.new(:cucumber)
end

desc 'Run my Spec'
task :spec do
  RSpec::Core::RakeTask.new(:spec)
end

task :default => [:all]

desc 'Run everything'
task :all do
  RSpec::Core::RakeTask.new(:all)
  Cucumber::Rake::Task.new(:all)
end

