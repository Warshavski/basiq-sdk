# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Basiq::Response do
  describe '.new' do
    subject { described_class.new(params) }

    context 'empty params' do
      subject { described_class.new }

      it { expect(subject.body).to eq({}) }

      it { expect(subject.headers).to eq({}) }
    end

    context 'only body param' do
      let(:params) { { body: { field: 'test' } } }

      it { expect(subject.body).to eq(field: 'test') }

      it { expect(subject.headers).to eq({}) }
    end

    context 'only headers param' do
      let(:params) { { headers: { cookie: 'test' } } }

      it { expect(subject.body).to eq({}) }

      it { expect(subject.headers).to eq(cookie: 'test') }
    end

    context 'body and headers params' do
      let(:params) do
        {
          body: { field: 'test' },
          headers: { cookie: 'test' }
        }
      end

      it { expect(subject.body).to eq(field: 'test') }

      it { expect(subject.headers).to eq(cookie: 'test') }
    end
  end

end
