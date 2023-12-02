# frozen_string_literal: true

class CampaignFinances < ApplicationRecord
  def self.find_in_propublica(cycle, _category)
    api_key = Rails.application.credentials.propublica[:api_key]
    Faraday.get(cycle)
  end
end
