# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Basiq::Client do
  before do
    stub_request(:get, "https://au-api.basiq.io/#{endpoint}")
      .to_return(body: body, status: status)

    stub_request(:post, "https://au-api.basiq.io/#{endpoint}")
      .to_return(body: body, status: status)

    allow_any_instance_of(described_class).to(
      receive(:headers).and_return('Authorization' => 'Bearer')
    )
  end

  describe '.users' do
    describe '.find_by_id' do
      subject { described_class.new('wat').users.find_by_id(user_id) }

      let(:user_id) { 1 }
      let(:endpoint) { "users/#{user_id}" }

      let(:body) do
        "{
            \"type\": \"user\",
            \"id\": \"ea3a81\",
            \"email\": \"gavin@hooli.com\",
            \"mobile\": \"+61410888666\",
            \"connections\": {
              \"type\": \"list\",
              \"count\": 1,
              \"data\": [
                {
                  \"type\": \"connection\",
                  \"id\": \"aaaf2c3b\",
                  \"links\": {
                    \"self\": \"https://au-api.basiq.io/users/ea3a81/connections/aaaf2c3b\"
                  }
                }
              ]
            },
            \"links\": {
              \"self\": \"https://au-api.basiq.io/users/ea3a81\",
              \"connections\": \"https://au-api.basiq.io/users/ea3a81/connections\"
            }
          }"
      end

      let(:status) { 200 }

      it { expect(subject).to be_an(Basiq::Entities::User) }

      it { expect(subject.id).to eq('ea3a81') }

      it { expect(subject.email).to eq('gavin@hooli.com') }

      it { expect(subject.mobile).to eq('+61410888666') }

      it { expect(subject.connections).to be_an(Array) }
    end

    describe '.create' do
      subject { described_class.new('wat').users.create(params) }

      let(:endpoint) { 'users' }

      let(:body) do
        "{
          \"type\": \"user\",
          \"id\": \"ea3a81\",
          \"email\": \"gavin@hooli.com\",
          \"mobile\": \"+61410888666\",
          \"links\": {
            \"self\": \"https://au-api.basiq.io/users/ea3a81\"
          }
        }"
      end
      let(:status) { 200 }

      let(:params) do
        {
          email: 'gavin@hooli.com',
          mobile: '+61410888666'
        }
      end

      it { expect(subject).to be_an(Basiq::Entities::User) }

      it { expect(subject.id).to eq('ea3a81') }

      it { expect(subject.email).to eq('gavin@hooli.com') }

      it { expect(subject.mobile).to eq('+61410888666') }
    end
  end
end
