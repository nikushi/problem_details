# frozen_string_literal: true

module ProblemDetails
  module Rails
    class RenderOptionBuilder
      # @param [Hash] content given as a value of :problem key of render method.
      # @param [Hash] options options of render method.
      def initialize(content, options)
        @content = content
        @options = options.dup
      end

      # @return [Hash] build a hash being passed to render method.
      def build
        content_type = @options.delete(:content_type) || 'application/problem+json'
        status = @options.delete(:status) || :ok
        document = ProblemDetails::Document.new(status: status, **@content)
        { json: document.to_h, status: status, content_type: content_type, **@options }
      end
    end
  end
end
