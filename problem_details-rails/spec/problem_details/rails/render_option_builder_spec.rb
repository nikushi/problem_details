# frozen_string_literal: true

require 'spec_helper'
require 'problem_details/rails/render_option_builder'

RSpec.describe ProblemDetails::Rails::RenderOptionBuilder do
  describe '#build' do
    subject { described_class.new(content, options).build }

    context 'example 1 in RFC' do
      let(:content) do
        {
          type: 'https://example.com/probs/out-of-credit',
          title: 'You do not have enough credit.',
          detail: 'Your current balance is 30, but that costs 50.',
          instance: '/account/12345/msgs/abc',
          balance: 30,
          accounts: ['/account/12345', '/account/67890'],
        }
      end
      let(:options) do
        {
          status: 403,
        }
      end
      let(:expected) do
        {
          json: {
            type: 'https://example.com/probs/out-of-credit',
            title: 'You do not have enough credit.',
            status: 403,
            detail: 'Your current balance is 30, but that costs 50.',
            instance: '/account/12345/msgs/abc',
            balance: 30,
            accounts: ['/account/12345', '/account/67890'],
          },
          status: 403,
          content_type: 'application/problem+json',
        }
      end

      it { is_expected.to eq expected }
    end
  end
end
