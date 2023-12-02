# frozen_string_literal: true

class CampaignFinancesController < ApplicationController
  def search
    @representatives = CampaignFinances.find_in_propublica(params[:cycle], params[:category])
  end
end
