# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ProblemDetails::Document do
  describe '.new' do
    subject { described_class.new(params) }

    let(:params) { {} }

    context 'without any params' do
      it { is_expected.to be_a described_class }
    end

    context 'without type' do
      it { expect(subject.type).to eq nil }
    end

    context 'with title' do
      let(:params) { { title: 'foo' } }

      it { expect(subject.title).to eq 'foo' }
    end

    context 'with status' do
      let(:params) { { status: 400 } }

      it { expect(subject.title).to eq 'Bad Request' }
      it { expect(subject.status).to eq 400 }
    end

    context 'with symbolized status' do
      let(:params) { { status: :bad_request } }

      it { expect(subject.title).to eq 'Bad Request' }
      it { expect(subject.status).to eq 400 }
    end

    context 'without status and title' do
      it { expect(subject.title).to be_nil }
      it { expect(subject.status).to be_nil }
    end
  end

  describe '#to_json' do
    subject { described_class.new(params).to_json }

    let(:params) do
      {
        type: 'https://example.com/probs/out-of-credit',
        title: 'You do not have enough credit.',
        detail: 'Your current balance is 30, but that costs 50.',
        instance: '/account/12345/msgs/abc',
        balance: 30,
        accounts: %w[/account/12345 /account/67890],
      }
    end

    it { is_expected.to eq params.to_json }
  end
end
