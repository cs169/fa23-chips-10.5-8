# frozen_string_literal: true

require 'rails_helper'

RSpec.describe County, type: :model do
  describe 'methods' do
    describe '#std_fips_code' do
      it 'returns a FIPS from a single digit' do
        c = described_class.new(fips_code: 9)
        expect(c.std_fips_code).to eq('009')
      end

      it 'returns a FIPS from double digits' do
        c = described_class.new(fips_code: 99)
        expect(c.std_fips_code).to eq('099')
      end

      it 'returns a FIPS from triple digits' do
        c = described_class.new(fips_code: 999)
        expect(c.std_fips_code).to eq('999')
      end
    end
  end
end
