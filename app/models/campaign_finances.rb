# frozen_string_literal: true

class CampaignFinances < ApplicationRecord
  class << self
    def find_in_propublica(cycle, category)
      response = make_api_call(cycle, category)
      raise "The response from ProPublica API failed: #{response.status}" unless response.success?

      data = JSON.parse(response.body)
      Rails.logger.debug { "Parsed JSON data: #{data.inspect}" }
      if data['results'].blank?
        []
      else
        data['results'].map do |result|
          {
            name:                   result['name'],
            party:                  result['party'],
            state:                  result['state'],
            total_from_individuals: result['total_from_individuals'],
            total_from_pacs:        result['total_from_pacs'],
            total_contributions:    result['total_contributions']
          }
        end
      end
    end

    private

    def make_api_call(cycle, category)
      base_url = 'https://api.propublica.org/campaign-finance/v1/'
      url = "#{base_url}#{cycle}/candidates/leaders/#{category}.json"
      api_key = Rails.application.credentials[:PROPUBLICA_API_KEY]
      Rails.logger.debug { "API Key: #{api_key}" }
      Faraday.get(url) do |req|
        req.headers['X-API-Key'] = api_key
      end
    end
  end
end
