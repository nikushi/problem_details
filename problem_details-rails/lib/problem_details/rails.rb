# frozen_string_literal: true

module ProblemDetails
  module Rails
    require 'problem_details'
    require_relative 'rails/config'
    require_relative 'rails/railtie' if defined?(::Rails)
    require_relative 'rails/version'
  end
end
