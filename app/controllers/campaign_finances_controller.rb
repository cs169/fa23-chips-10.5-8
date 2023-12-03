# frozen_string_literal: true

class CampaignFinancesController < ApplicationController
  def search
    @representatives = CampaignFinances.find_in_propublica(params[:cycle], params[:category])
    return unless @representatives.empty?

    flash[:error] = 'No representatives found with given parameters!'
  end
end
