# frozen_string_literal: true

require 'rails_helper'
require 'spec_helper'
require 'support/campaign_finances_request_helper'

describe CampaignFinances do
  describe 'searching ProPublica by keyword' do
    let(:my_json_stub) do
      {
        status:    'OK',
        copyright: 'Copyright (c) 2023 ProPublica Inc. All Rights Reserved.',
        cycle:     2020,
        category:  'Contributions from PACs',
        base_uri:  'https://api.propublica.org/campaign-finance/v1/2020/',
        results:   [
          {
            relative_uri:           '/candidates/S4GA11285.json',
            name:                   'PERDUE, DAVID',
            party:                  'REP',
            state:                  '/races/GA.json',
            district:               '00',
            committee:              '/committees/C00547570.json',
            status:                 'I',
            total_from_individuals: 75_574_377.42,
            total_from_pacs:        4_851_577.45,
            total_contributions:    80_425_954.87,
            candidate_loans:        0.0,
            total_disbursements:    88_492_643.47,
            begin_cash:             1_703_670.97,
            end_cash:               12_414_001.63,
            total_refunds:          162_391.11,
            debts_owed:             781_801.79,
            date_coverage_from:     '2019-01-01',
            date_coverage_to:       '2020-12-31'
          }
        ]
      }
    end

    before do
      stub_request(:get, /api.propublica.org/)
        .with(headers: { 'X-API-Key' => Rails.application.credentials[:PROPUBLICA_API_KEY] })
        .to_return(status: 200, body: JSON.generate(my_json_stub), headers: {})
    end

    it 'calls ProPublica with valid API key' do
      results = described_class.find_in_propublica('2020', 'pac-total')
      expect(results).not_to be_empty
      expect(results.first[:name]).to eq('PERDUE, DAVID')
    end

    it 'returns an empty array when results is nil' do
      stub_propublica_api(my_json_stub.merge(results: nil))
      results = described_class.find_in_propublica('2020', 'pac-total')
      expect(results).to eq([])
    end

    it 'returns an empty array when results is empty' do
      stub_propublica_api(my_json_stub.merge(results: []))
      results = described_class.find_in_propublica('2020', 'pac-total')
      expect(results).to eq([])
    end
  end
end
