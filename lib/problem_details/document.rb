# frozen_string_literal: true

require 'json'
require 'rack/utils'

# An object representing RFC 7807 Problem Details
module ProblemDetails
  # The class that implements a Problem Details JSON object described in RFC 7807.
  class Document
    attr_accessor :type, :title, :status, :detail, :instance

    def initialize(params = {})
      params = params.dup
      @type = params.delete(:type) || 'about:blank'
      @status = Rack::Utils.status_code(params.delete(:status)) if params.key?(:status)
      @title = params.delete(:title) || (@status ? ::Rack::Utils::HTTP_STATUS_CODES[@status] : nil)
      @detail = params.delete(:detail)
      @instance = params.delete(:instance)
      @extentions = params
    end

    def to_h
      h = {}
      %i[type title status detail instance].each do |key|
        value = public_send(key)
        h[key] = value if value
      end
      h.merge(@extentions)
    end

    def to_json
      to_h.to_json
    end
  end
end
