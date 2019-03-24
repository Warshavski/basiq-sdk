# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Basiq::FilterBuilder do
  let(:field) { 'quantity' }
  let(:value) { 12 }

  describe '#initialize' do
    subject { described_class.new }

    it { expect(subject.filters).to eq([]) }
  end

  describe '#eq' do
    subject { described_class.new.eq(field, value) }

    it { expect(subject).to be_an(described_class) }

    it { expect(subject.filters).to eq(["quantity.eq('12')"]) }
  end

  describe '#gt' do
    subject { described_class.new.gt(field, value) }

    it { expect(subject).to be_an(described_class) }

    it { expect(subject.filters).to eq(["quantity.gt('12')"]) }
  end

  describe '#gteq' do
    subject { described_class.new.gteq(field, value) }

    it { expect(subject).to be_an(described_class) }

    it { expect(subject.filters).to eq(["quantity.gteq('12')"]) }
  end

  describe '#lt' do
    subject { described_class.new.lt(field, value) }

    it { expect(subject).to be_an(described_class) }

    it { expect(subject.filters).to eq(["quantity.lt('12')"]) }
  end

  describe '#lteq' do
    subject { described_class.new.lteq(field, value) }

    it { expect(subject).to be_an(described_class) }

    it { expect(subject.filters).to eq(["quantity.lteq('12')"]) }
  end

  describe '#bt' do
    let(:first_value) { value }
    let(:last_value)  { 13 }

    subject { described_class.new.bt(field, first_value, last_value) }

    it { expect(subject).to be_an(described_class) }

    it { expect(subject.filters).to eq(["quantity.bt('12', '13')"]) }
  end

  describe '#biuld' do
    let(:builder) { described_class.new }

    subject { builder.build }

    context 'single filter' do
      before do
        allow(builder).to receive(:filters).and_return(["quantity.lteq('12')"])
      end

      it { expect(subject).to be_an(String) }

      it { expect(subject).to eq("filter=quantity.lteq('12')") }
    end

    context 'multiple filters' do
      before do
        allow(builder).to(
          receive(:filters).and_return(["quantity.lteq('12')", "price.bt('1', '2')"])
        )
      end

      it { expect(subject).to be_an(String) }

      it { expect(subject).to eq("filter=quantity.lteq('12'),price.bt('1', '2')") }
    end
  end
end
