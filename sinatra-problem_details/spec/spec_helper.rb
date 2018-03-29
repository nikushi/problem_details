# frozen_string_literal: true

ENV['RACK_ENV'] = 'test'
require 'bundler/setup'

require 'sinatra/contrib'
require 'sinatra-problem_details'

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = '.rspec_status'

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.include Sinatra::TestHelpers
end
