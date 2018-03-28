# frozen_string_literal: true

module ProblemDetails
  module Rails
    # Configures global settings for ProblemDetails::Rails
    #   ProblemDetails::Rails.configure do |config|
    #     config.default_json_content_type = 'application/json'
    #   end
    class << self
      def configure
        yield config
      end

      def config
        @config ||= Config.new
      end
    end

    class Config
      attr_accessor :default_json_content_type

      def initialize
        @default_json_content_type = 'application/problem+json'
      end
    end
  end
end
