# frozen_string_literal: true

require 'rails_helper'

if RUBY_VERSION >= '2.6.0'
  if Rails.version < '5'
    class ActionController::TestResponse < ActionDispatch::TestResponse
      def recycle!
        # HACK: to avoid MonitorMixin double-initialize error:
        @mon_mutex_owner_object_id = nil
        @mon_mutex = nil
        initialize
      end
    end
  else
    puts 'Monkeypatch for ActionController::TestResponse no longer needed'
  end
end

describe CampaignFinancesController do
  describe 'searching ProPublica' do
    before do
      @fake_results = [instance_double(Representative, name: 'Jason'),
                       instance_double(Representative, name: 'Kevin')]
      allow(CampaignFinances).to receive(:find_in_propublica).and_return(@fake_results)
    end

    it 'calls the model method that performs ProPublica search' do
      get :search, params: { cycle: '2020', category: 'PAC Total' }
      expect(CampaignFinances).to have_received(:find_in_propublica).with('2020', 'PAC Total')
    end

    describe 'after valid search' do
      before do
        allow(CampaignFinances).to receive(:find_in_propublica).and_return(@fake_results)
        get :search, params: { cycle: '2020', category: 'PAC Total' }
      end

      it 'selects the Search Results template for rendering' do
        expect(response).to render_template('search')
      end

      it 'makes the ProPublica search results available to that template' do
        expect(assigns(:representatives)).to eq(@fake_results)
      end
    end
  end
end
