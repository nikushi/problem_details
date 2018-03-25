require "problem_details/version"
require "problem_details/document"
require 'problem_details/railtie' if defined?(::Rails)

module ProblemDetails
  CONTENT_TYPES = {
    json: 'application/problem+json',
     xml: 'application/problem+xml', # not supported right now
  }.freeze

  class << self
    def lookup_content_type(kind)
      CONTENT_TYPES[kind]
    end
  end
end
