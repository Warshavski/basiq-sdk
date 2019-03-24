# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Basiq::Query do
  context 'filters' do
    let(:query) do
      described_class.new('test', 'test', parser, filter_builder)
    end

    let(:parser) do
      double('dummy parser', parse: 'wat')
    end

    let(:filter_builder) do
      double('dummy builder', eq: self, gt: self, gteq: self, lt: self, lteq: self)
    end

    describe '#eq' do
      subject { query.eq('wat', 'so') }

      it { expect(subject).to eq(query) }

      it 'delegates filters to the filter builder' do
        expect(filter_builder).to receive(:eq).with('wat', 'so')
        subject
      end
    end

    describe '#gt' do
      subject { query.gt('wat', 'so') }

      it { expect(subject).to eq(query) }

      it 'delegates filters to the filter builder' do
        expect(filter_builder).to receive(:gt).with('wat', 'so')
        subject
      end
    end

    describe '#gteq' do
      subject { query.gteq('wat', 'so') }

      it { expect(subject).to eq(query) }

      it 'delegates filters to the filter builder' do
        expect(filter_builder).to receive(:gteq).with('wat', 'so')
        subject
      end
    end

    describe '#lt' do
      subject { query.lt('wat', 'so') }

      it { expect(subject).to eq(query) }

      it 'delegates filters to the filter builder' do
        expect(filter_builder).to receive(:lt).with('wat', 'so')
        subject
      end
    end

    describe '#lteq' do
      subject { query.lteq('wat', 'so') }

      it { expect(subject).to eq(query) }

      it 'delegates filters to the filter builder' do
        expect(filter_builder).to receive(:lteq).with('wat', 'so')
        subject
      end
    end
  end
end
