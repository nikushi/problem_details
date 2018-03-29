# frozen_string_literal: true

require 'sinatra/base'
require 'sinatra/json'
require 'problem_details'

module Sinatra
  module ProblemDetails
    module Helpers
      def problem(object, options = {})
        options = { content_type: settings.problem_json_content_type }.merge(options)
        document = ::ProblemDetails::Document.new(status: status, **object)
        json(document.to_h, options)
      end
    end

    def self.registered(base)
      base.set :problem_json_content_type, 'application/problem+json'
      base.helpers Helpers
    end
  end

  register ProblemDetails
end
