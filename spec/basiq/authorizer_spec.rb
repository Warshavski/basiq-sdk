# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Basiq::Authorizer do
  let(:endpoints) do
    %w[https://j%98%A4%7B@au-api.basiq.io/token https://au-api.basiq.io/token]
  end

  before do
    endpoints.each do |endpoint|
      stub_request(:post, endpoint).to_return(body: body, status: status)
    end
  end

  describe '#obtain_token' do
    subject { described_class.new('api_key').obtain_token }

    context 'valid response' do
      let(:body) do
        '{"access_token":"ACCESS_TOKEN","token_type":"Bearer","expires_in":3600}'
      end

      let(:status) { 200 }

      it { expect(subject).to be_an(Basiq::Entities::AccessToken) }

      it { expect(subject.token).to eq('ACCESS_TOKEN') }

      it { expect(subject.type).to eq('Bearer') }

      it { expect(subject.expires_in).to eq(3600) }
    end

    context 'error status' do
      let(:body) do
        "{
          \"type\": \"list\",
          \"correlationId\": \"bd1183d9-c9d8-11e7-909a-6789bfc80ac5\",
          \"data\": [
            {
              \"type\": \"error\",
              \"code\": \"parameter-not-supplied\",
              \"title\": \"Required parameter not supplied\",
              \"detail\": \"Institution ID  parameter is required.\",
              \"source\": {
                \"pointer\": \"connection/institution/id\",
                \"parameter\": \"id\"
              }
            }
          ]
        }"
      end

      let(:status) { 400 }

      it { expect { subject }.to raise_error(Basiq::ServiceError) }
    end

    context 'invalid body' do
      let(:body)    { 'so-so' }
      let(:status)  { 200 }

      it { expect { subject }.to raise_error(Basiq::ServiceError) }
    end

    context 'empty body' do
      let(:body)    { '' }
      let(:status)  { 200 }

      it { expect(subject).to be_nil }
    end
  end
end
