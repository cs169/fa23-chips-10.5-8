# frozen_string_literal: true

require 'rails_helper'

RSpec.describe MyNewsItemsController, type: :controller do
  describe 'populate issues list' do
    it 'assigns @issues_list with all valid issues' do
      controller.send(:set_issues_list)
      expect(assigns(:issues_list)).to eq(NewsItem::VALID_ISSUES)
    end
  end
end
