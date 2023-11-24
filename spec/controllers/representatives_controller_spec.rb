# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RepresentativesController, type: :controller do
  describe 'GET show' do
    before do
      @representative = instance_double(Representative, id: 1, street: '123 Main St', city: 'Los Angeles', state: 'CA',
    zip: '90001', political_party: 'Democrat', photo: 'http://example.com/karen_bass.jpg')
    end

    it 'renders the show template with representative details' do
      # Stub the find method
      allow(Representative).to receive(:find).with('1').and_return(@representative)

      get :show, params: { id: 1 }

      expect(response).to render_template(:show)
      expect(assigns(:representative)).to eq(@representative)
    end
  end
end
