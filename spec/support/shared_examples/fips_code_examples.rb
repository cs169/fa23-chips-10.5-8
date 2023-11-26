# frozen_string_literal: true

RSpec.shared_examples 'a model of state or county' do |model, padding|
  [
    [9, '9'.rjust(padding, '0')],
    [99, '99'.rjust(padding, '0')],
    [999, '999']
  ].each do |fips_code, expected_code|
    it "returns the correct FIPS code for #{fips_code}" do
      new_instance = model.new(fips_code: fips_code)
      expect(new_instance.std_fips_code).to eq(expected_code)
    end
  end
end
