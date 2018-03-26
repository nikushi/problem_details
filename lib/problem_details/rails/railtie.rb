# frozen_string_literal: true

module ProblemDetails
  class Railtie < ::Rails::Railtie
    initializer 'problem_details.initialize' do |_app|
      ActiveSupport.on_load(:action_controller) do
        require 'problem_details'
        require 'problem_details/rails/render_option_builder'

        ActionController::Renderers.add :problem do |content, options|
          builder = ProblemDetails::Rails::RenderOptionBuilder.new(content, options)
          render(**builder.build)
        end
      end
    end
  end
end
