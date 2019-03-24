require 'spec_helper'

RSpec.describe Basiq::ServiceError do

  describe '.new' do
    context 'empty params' do
      subject { described_class.new }

      it { expect(subject.message).to eq(' @title=nil, @detail=nil, @body=nil, @raw_body=nil, @status_code=nil') }

      it { expect(subject.title).to be_nil }

      it { expect(subject.detail).to be_nil }

      it { expect(subject.body).to be_nil }

      it { expect(subject.raw_body).to be_nil }

      it { expect(subject.status_code).to be_nil }
    end

    context 'only message' do
      subject { described_class.new('test message') }

      it { expect(subject.message).to eq('test message @title=nil, @detail=nil, @body=nil, @raw_body=nil, @status_code=nil') }

      it { expect(subject.title).to be_nil }

      it { expect(subject.detail).to be_nil }

      it { expect(subject.body).to be_nil }

      it { expect(subject.raw_body).to be_nil }

      it { expect(subject.status_code).to be_nil }
    end

    context 'message and params' do
      subject { described_class.new('test message', params) }

      let(:params) do
        {
          title: 'title',
          detail: 'detail',
          body: 'body',
          raw_body: 'raw_body',
          status_code: 'status_code'
        }
      end

      it { expect(subject.message).to eq("test message @title=\"title\", @detail=\"detail\", @body=\"body\", @raw_body=\"raw_body\", @status_code=\"status_code\"") }

      it { expect(subject.title).to eq('title') }

      it { expect(subject.detail).to eq('detail') }

      it { expect(subject.body).to eq('body') }

      it { expect(subject.raw_body).to eq('raw_body') }

      it { expect(subject.status_code).to eq('status_code') }
    end
  end

  describe '#to_s' do
    subject { described_class.new(message, params).to_s }

    let(:message) { 'test message' }

    let(:params) do
      {
        title: 'title',
        detail: 'detail',
        body: 'body',
        raw_body: 'raw_body',
        status_code: 'status_code'
      }
    end

    it { expect(subject).to eq("test message @title=\"title\", @detail=\"detail\", @body=\"body\", @raw_body=\"raw_body\", @status_code=\"status_code\"") }
  end
end
