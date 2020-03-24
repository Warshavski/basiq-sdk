# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Basiq::Cursor do
  describe '#each' do
    let(:first_batch) do
      {
        entities: [1, 2, 3],
        links: { next: 'next' }
      }
    end

    let(:last_batch) do
      {
        entities: [4, 5],
        links: { self: 'self' }
      }
    end

    let(:requester) { double('requester') }

    before do
      allow(requester).to receive(:call).with('endpoint').and_return(first_batch)
      allow(requester).to receive(:call).with('next').and_return(last_batch)
    end

    subject do
      described_class.new('endpoint') do |url|
        requester.call(url)
      end
    end

    it 'is expected to iterate through fetched collection' do
      actual_collection = subject.lazy.each_with_object([]) { |e, acc| acc << e }

      expect(actual_collection).to eq([1, 2, 3, 4, 5])
    end
  end
end
