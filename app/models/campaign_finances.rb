# frozen_string_literal: true

class CampaignFinances < ApplicationRecord
  def self.find_in_propublica(cycle, _category)
    Faraday.get(cycle)
  end
end
