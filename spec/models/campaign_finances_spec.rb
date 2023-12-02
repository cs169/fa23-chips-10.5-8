# frozen_string_literal: true

require 'rails_helper'
require 'spec_helper'

describe CampaignFinances do
  describe 'searching ProPublica by keyword' do
    before do
      @fake_results = instance_double(Faraday::Response, body: 'fake response body')
      allow(Faraday).to receive(:get).and_return(@fake_results)
    end

    it 'calls Faraday gem with CS169 domain' do
      described_class.find_in_propublica('https://cs169.org', 'PAC Total')
      expect(Faraday).to have_received(:get).with('https://cs169.org')
    end
  end
end
