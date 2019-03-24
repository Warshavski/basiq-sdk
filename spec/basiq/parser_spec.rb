# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Basiq::Parser do
  subject { described_class.new.parse(data) }

  describe '#parse' do
    context 'institution' do
      let(:data) do
        {
          type: 'institution',
          id: 'AU00000',
          name: 'Basiq Test Bank',
          shortName: 'Basiq Test Bank',
          institutionType: 'Test Bank',
          country: 'Australia',
          serviceName: 'Personal Online Banking',
          serviceType: 'Test',
          loginIdCaption: 'Login',
          passwordCaption: 'Password',
          tier: '4',
          logo: {
            type: 'image',
            colors: { primary: '#000000' },
            links: {
              square: 'https://s3-ap-southeast-2.amazonaws.com/basiq-institutions/AU00000.svg',
              full: 'https://s3-ap-southeast-2.amazonaws.com/basiq-institutions/AU00000-full.svg'
            }
          },
          links: {
            self: 'https://au-api.basiq.io/institutions/AU00000'
          }
        }
      end

      let(:model) { Basiq::Entities::Institution }

      it 'returns basiq entity' do
        expect(subject).to be_an(model)
      end

      it 'returns model with parsed data' do
        expect(subject.type).to eq('institution')
        expect(subject.id).to eq('AU00000')
        expect(subject.name).to eq('Basiq Test Bank')
        expect(subject.short_name).to eq('Basiq Test Bank')
        expect(subject.institution_type).to eq('Test Bank')
        expect(subject.service_name).to eq('Personal Online Banking')
        expect(subject.service_type).to eq('Test')
        expect(subject.login_id_caption).to eq('Login')
        expect(subject.password_caption).to eq('Password')
        expect(subject.tier).to eq('4')
      end
    end

    context 'institution list' do
      let(:data) do
        {
          type: 'list',
          size: 89,
          data: [
            {
              type: 'institution',
              id: 'AU00000',
              name: 'Basiq Test Bank',
              shortName: 'Basiq Test Bank',
              institutionType: 'Test Bank',
              country: 'Australia',
              serviceName: 'Personal Online Banking',
              serviceType: 'Test',
              loginIdCaption: 'Login',
              passwordCaption: 'Password',
              tier: '4',
              logo: {
                type: 'image',
                colors: {
                  primary: '#000000'
                },
                links: {
                  square: 'https://s3-ap-southeast-2.amazonaws.com/basiq-institutions/AU00000.svg',
                  full: 'https://s3-ap-southeast-2.amazonaws.com/basiq-institutions/AU00000-full.svg'
                }
              },
              links: {
                self: 'https://au-api.basiq.io/institutions/AU00000'
              }
            },
            nil
          ],
          links: {
            self: 'https://au-api.basiq.io/institutions'
          }
        }
      end
      let(:model) { Basiq::Entities::Institution }

      it { expect(subject).to be_an(Array) }

      it { expect(subject.first).to be_an(model) }

      it 'returns model with parsed data' do
        entity = subject.first

        expect(entity.type).to eq('institution')
        expect(entity.id).to eq('AU00000')
        expect(entity.name).to eq('Basiq Test Bank')
        expect(entity.short_name).to eq('Basiq Test Bank')
        expect(entity.institution_type).to eq('Test Bank')
        expect(entity.service_name).to eq('Personal Online Banking')
        expect(entity.service_type).to eq('Test')
        expect(entity.login_id_caption).to eq('Login')
        expect(entity.password_caption).to eq('Password')
        expect(entity.tier).to eq('4')
      end
    end
  end
end
