# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Basiq::Entities::AccessToken do
  describe '.new' do
    subject do
      described_class.new(token: 'token', type: 'Bearer', expires_in: 3600)
    end

    it { expect(subject.token).to eq('token') }

    it { expect(subject.type).to eq('Bearer') }

    it { expect(subject.expires_in).to eq(3600) }
  end

  describe '#valid?' do
    subject { described_class.new(params).valid? }

    context 'valid token' do
      let(:params) do
        { token: 'token', type: 'Bearer', expires_in: 3600 }
      end

      it { expect(subject).to be(true) }
    end

    context 'valid token' do
      let(:params) do
        { token: 'token', type: 'Bearer', expires_in: 0 }
      end

      it { expect(subject).to be(false) }
    end
  end
end
