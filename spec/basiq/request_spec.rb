# frozen_string_literal: true

require 'spec_helper'

describe Basiq::Request do
  let(:endpoint) { 'test' }
  let(:api_root) { 'https://au-api.basiq.io' }

  describe '#get' do
    subject { described_class.new(endpoint).get }

    it 'surfaces client request exceptions as a Basiq::ServiceError' do
      exception = Faraday::ClientError.new('the server responded with status 503')

      stub_request(:get, "#{api_root}/#{endpoint}").to_raise(exception)

      expect { subject }.to raise_error(Basiq::ServiceError)
    end

    it 'surfaces an unparseable response body as a Basiq::ServiceError' do
      response_values = { status: 503, headers: {}, body: '[foo]' }

      exception = Faraday::ClientError.new('the server responded with status 503', response_values)

      stub_request(:get, "#{api_root}/#{endpoint}").to_raise(exception)

      expect { subject }.to raise_error(Basiq::ServiceError)
    end
  end

  describe '#post' do
    subject { described_class.new(endpoint).post }

    it 'surfaces client request exceptions as a Basiq::ServiceError' do
      exception = Faraday::ClientError.new('the server responded with status 503')

      stub_request(:post, "#{api_root}/#{endpoint}").to_raise(exception)

      expect { subject }.to raise_error(Basiq::ServiceError)
    end

    it 'surfaces an unparseable response body as a Basiq::ServiceError' do
      response_values = { status: 503, headers: {}, body: '[foo]' }

      exception = Faraday::ClientError.new('the server responded with status 503', response_values)

      stub_request(:post, "#{api_root}/#{endpoint}").to_raise(exception)

      expect { subject }.to raise_error(Basiq::ServiceError)
    end
  end

  describe '#handle_error' do
    it "includes status and raw body even when json can't be parsed" do
      response_values = { status: 503, headers: {}, body: 'A non JSON response' }

      exception = Faraday::ClientError.new('the server responded with status 503', response_values)

      begin
        described_class.new(endpoint).send(:handle_error, exception)
      rescue StandardError => boom
        expect(boom.status_code).to eq 503
        expect(boom.raw_body).to eq 'A non JSON response'
      end
    end
  end
end
