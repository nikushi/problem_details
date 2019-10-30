# frozen_string_literal: true

require 'spec_helper'
require 'json'

RSpec.describe Sinatra::ProblemDetails do
  def mock_app(&block)
    super do
      register Sinatra::ProblemDetails
      class_eval(&block)
    end
  end

  def results_in(obj)
    expect(JSON.parse(get('/').body)).to eq(obj)
  end

  it "encodes objects with default status" do
    mock_app { get('/') { problem :foo => [1, 'bar', nil] } }
    results_in 'status' => 200, 'title' => 'OK', 'foo' => [1, 'bar', nil]
  end

  it "encodes objects with given status" do
    mock_app do
      get('/') do
        status 404
        problem :foo => [1, 'bar', nil]
      end
    end
    results_in 'status' => 404, 'title' => 'Not Found', 'foo' => [1, 'bar', nil]
  end

  it "encodes objects with status and other properties including reserved ones in RFC" do
    mock_app do
      get('/') do
        status 403
        problem(
          type: 'https://example.com/probs/out-of-credit',
          title: 'You do not have enough credit.',
          detail: 'Your current balance is 30, but that costs 50.',
          instance: '/account/12345/msgs/abc',
          balance: 30,
          accounts: ['/account/12345', '/account/67890'],
        )
      end
    end
    results_in(
      'status' => 403,
      'type' => 'https://example.com/probs/out-of-credit',
      'title' => 'You do not have enough credit.',
      'detail' => 'Your current balance is 30, but that costs 50.',
      'instance' => '/account/12345/msgs/abc',
      'balance' => 30,
      'accounts' => ['/account/12345', '/account/67890'],
    )
  end

  it "sets the content type to 'application/problem+json'" do
    mock_app { get('/') { problem({}) } }
    expect(get('/')["Content-Type"]).to include("application/problem+json")
  end

  it "allows overriding content type with :content_type" do
    mock_app { get('/') { json({}, :content_type => "application/json") } }
    expect(get('/')["Content-Type"]).to eq("application/json")
  end
end
