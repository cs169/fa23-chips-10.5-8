# frozen_string_literal: true

module CampaignFinancesRequestHelper
  def stub_propublica_api(json_stub)
    stub_request(:get, /api.propublica.org/)
      .with(headers: { 'X-API-Key' => Rails.application.credentials[:PROPUBLICA_API_KEY] })
      .to_return(status: 200, body: JSON.generate(json_stub), headers: {})
  end
end

RSpec.configure do |config|
  config.include CampaignFinancesRequestHelper
end
