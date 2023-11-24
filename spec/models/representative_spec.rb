require 'rails_helper'
require 'spec_helper'
require 'ostruct'

RSpec.describe Representative, type: :model do
  describe '.civic_api_to_representative_params' do
    let(:rep_info) do
      OpenStruct.new(
        officials: [OpenStruct.new(name: 'Karen Bass')],
        offices:   [OpenStruct.new(name: 'Mayor', division_id: 'ocd-division/country:us/state:ca/city:los_angeles',
                                   official_indices: [0])]
      )
    end

    before { described_class.civic_api_to_representative_params(rep_info) }

    it 'creates a new representative' do
      expect(described_class.count).to eq(1)
    end

    it 'does not create a new representative if the representative already exists' do
      described_class.civic_api_to_representative_params(rep_info)
      expect(described_class.count).to eq(1)
    end
  end
end
