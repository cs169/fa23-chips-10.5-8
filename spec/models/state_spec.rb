require 'rails_helper'

RSpec.describe State, type: :model do
  describe '#std_fips_code' do
    it 'returns a FIPS from a single digit' do
      s = described_class.new(fips_code: 9)
      expect(s.std_fips_code).to eq('09')
    end

    it 'returns a FIPS from double digits' do
      s = described_class.new(fips_code: 99)
      expect(s.std_fips_code).to eq('99')
    end

    it 'returns a FIPS from triple digits' do
      s = described_class.new(fips_code: 999)
      expect(s.std_fips_code).to eq('999')
    end
  end
end