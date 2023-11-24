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

    it 'creates or updates Representative records with the correct street and city parameters' do
      @representatives.each do |representative|
        expect(representative).to be_persisted
        expect(representative.street).to eq('123 Main St')
        expect(representative.city).to eq('Los Angeles')
      end
    end

    it 'creates or updates Representative records with the correct name and ocdid parameters' do
      @representatives.each do |representative|
        expect(representative).to be_persisted
        expect(representative.name).to eq('Karen Bass')
        expect(representative.ocdid).to eq('ocd-division/country:us/state:ca/city:los_angeles')
      end
    end

    it 'creates or updates Representative records with the correct zip and party parameters' do
      @representatives.each do |representative|
        expect(representative).to be_persisted
        expect(representative.zip).to eq('90001')
        expect(representative.political_party).to eq('Democrat')
      end
    end

    it 'creates or updates Representative records with the correct state and title parameters' do
      @representatives.each do |representative|
        expect(representative).to be_persisted
        expect(representative.state).to eq('CA')
        expect(representative.title).to eq('Mayor')
      end
    end

    it 'creates or updates Representative records with the correct picture parameters' do
      @representatives.each do |representative|
        expect(representative).to be_persisted
        expect(representative.photo).to eq('http://example.com/karen_bass.jpg')
      end
    end
  end
end
