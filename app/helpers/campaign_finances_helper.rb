# frozen_string_literal: true

module CampaignFinancesHelper
  def display_state(state)
    return '' if state.nil?

    state.split('/').last.split('.').first
  end
end
