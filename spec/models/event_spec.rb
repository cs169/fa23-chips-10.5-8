# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Event, type: :model do
  describe 'methods' do
    describe '#county_names_by_id' do
      it 'returns empty on nil country or state' do
        e = described_class.new
        expect(e.county_names_by_id).to eq({})
      end
    end
  end
end
