# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ProblemDetails::Rails::Config do
  describe 'default_json_content_type' do
    subject { ProblemDetails::Rails.config.default_json_content_type }

    context 'by default' do
      it { is_expected.to eq 'application/problem+json' }
    end
    context 'configure via a config block' do
      before do
        ProblemDetails::Rails.configure { |c| c.default_json_content_type = 'application/json' }
      end
      after do
        ProblemDetails::Rails.configure { |c| c.default_json_content_type = 'application/problem+json' }
      end
      it { is_expected.to eq 'application/json' }
    end
  end
end
