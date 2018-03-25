# frozen_string_literal: true

require "bundler/gem_helper"
require "rspec/core/rake_task"

# For multiple gems
# ref https://github.com/bkeepers/dotenv/blob/master/Rakefile

namespace "problem_details" do
	Bundler::GemHelper.install_tasks name: "problem_details"
end

namespace "problem_details-rails" do
	class ProblemDetailsRailsGemHelper < Bundler::GemHelper
    def guard_already_tagged; end # noop

    def tag_version; end # noop
  end

  ProblemDetailsRailsGemHelper.install_tasks name: "problem_details-rails"
end

desc 'build gem'
task build: ["problem_details:build", "problem_details-rails:build"]

desc 'build and install'
task install: ["problem_details:install", "problem_details-rails:install"]

desc 'release'
task release: ["problem_details:release", "problem_details-rails:release"]

RSpec::Core::RakeTask.new(:spec)
task :default => :spec
