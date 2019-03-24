# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Basiq::Entities::Institution do
  let(:entity) do
    described_class.new(
      id: 'test',
      name: 'test',
      short_name: 'test',
      country: 'test',
      service_name: 'test',
      service_type: 'test',
      institution_type: 'test',
      tier: 'test',
      login_id_caption: 'test',
      password_caption: 'test',
      logo: 'test'
    )
  end

  describe '#to_h' do
    subject { entity.to_h }

    it { expect(subject).to be_an(Hash) }

    it 'returns hash with model attribute keys' do
      expected_keys = %i[
        id
        name
        short_name
        country
        service_name
        service_type
        institution_type
        tier
        login_id_caption
        password_caption
        logo
      ]

      actual_keys = subject.keys

      expect(actual_keys).to match_array(expected_keys)
    end
  end
end
