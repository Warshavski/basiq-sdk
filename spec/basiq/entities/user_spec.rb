# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Basiq::Entities::User do
  let(:entity) do
    described_class.new(
      id: 1,
      email: 'email@test.test',
      mobile: '+9778866',
      name: 'name'
    )
  end

  describe '#to_h' do
    subject { entity.to_h }

    it { expect(subject).to be_an(Hash) }

    it 'returns hash with model attribute keys' do
      expected_keys = %i[id email mobile name]

      actual_keys = subject.keys

      expect(actual_keys).to match_array(expected_keys)
    end
  end
end
