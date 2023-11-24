# frozen_string_literal: true

require 'rails_helper'
require 'spec_helper'
require 'ostruct'

RSpec.describe Representative, type: :model do
  describe '.civic_api_to_representative_params' do
    let(:rep_info) do
      OpenStruct.new(
        officials: [OpenStruct.new(name: 'Karen Bass', address: [
                                     OpenStruct.new(
                                       line1: '123 Main St',
                                       city:  'Los Angeles',
                                       state: 'CA',
                                       zip:   '90001'
                                     )
                                   ], party: 'Democrat', photo_url: 'http://example.com/karen_bass.jpg')],
        offices:   [OpenStruct.new(name: 'Mayor', division_id: 'ocd-division/country:us/state:ca/city:los_angeles',
                                   official_indices: [0])]
      )
    end

    before { @representatives = described_class.civic_api_to_representative_params(rep_info) }

    it 'creates a new representative' do
      expect(described_class.count).to eq(1)
    end

    it 'does not create a new representative if the representative already exists' do
      described_class.civic_api_to_representative_params(rep_info)
      expect(described_class.count).to eq(1)
    end

    shared_examples 'creates or updates Representative records with correct parameters' do |attribute, expected_value|
      it "#{attribute} parameter" do
        @representatives.each do |representative|
          expect(representative).to be_persisted
          expect(representative.public_send(attribute)).to eq(expected_value)
        end
      end
    end

    context 'when creates or updates Representative records with correct' do
      include_examples 'creates or updates Representative records with correct parameters', :street, '123 Main St'
      include_examples 'creates or updates Representative records with correct parameters', :city, 'Los Angeles'
      include_examples 'creates or updates Representative records with correct parameters', :name, 'Karen Bass'
      include_examples 'creates or updates Representative records with correct parameters', :ocdid,
                       'ocd-division/country:us/state:ca/city:los_angeles'
      include_examples 'creates or updates Representative records with correct parameters', :zip, '90001'
      include_examples 'creates or updates Representative records with correct parameters', :political_party,
                       'Democrat'
      include_examples 'creates or updates Representative records with correct parameters', :state, 'CA'
      include_examples 'creates or updates Representative records with correct parameters', :title, 'Mayor'
      include_examples 'creates or updates Representative records with correct parameters', :photo, 'http://example.com/karen_bass.jpg'
    end
  end
end
