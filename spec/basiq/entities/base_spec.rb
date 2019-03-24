# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Basiq::Entities::Base do
  before do
    class FakeEntity < Basiq::Entities::Base
      attr_accessor :dump, :status, :name
    end
  end

  after { Object.send :remove_const, :FakeEntity }

  describe '.new' do
    context 'initialize through arguments' do
      subject { FakeEntity.new(attributes) }

      context 'valid attributes' do
        let(:attributes) do
          { status: 'wat', name: 'so', dump: %w[wat so] }
        end

        it { expect(subject.status).to eq('wat') }

        it { expect(subject.name).to eq('so') }

        it { expect(subject.dump).to eq(%w[wat so]) }
      end

      context 'invalid attributes type' do
        let(:attributes) { %w[wat so] }

        it { expect { subject }.to raise_error(ArgumentError) }
      end
    end

    context 'initialize through block' do
      subject { FakeEntity.new(&block) }

      let(:block) do
        lambda do |r|
          r.status = 'so'
          r.name = 'wat'
          r.dump = %w[so wat]
        end
      end

      it { expect(subject.status).to eq('so') }

      it { expect(subject.name).to eq('wat') }

      it { expect(subject.dump).to eq(%w[so wat]) }
    end
  end
end
