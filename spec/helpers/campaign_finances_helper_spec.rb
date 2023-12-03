# frozen_string_literal: true

require 'rails_helper'
require 'spec_helper'

RSpec.describe CampaignFinancesHelper, type: :helper do
  describe '#display_state' do
    it 'returns an empty string when state is nil' do
      expect(helper.display_state(nil)).to eq('')
    end

    it 'returns the state code when state is a valid string' do
      expect(helper.display_state('/races/FL.json')).to eq('FL')
    end
  end
end
