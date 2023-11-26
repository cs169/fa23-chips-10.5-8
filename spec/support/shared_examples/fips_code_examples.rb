# frozen_string_literal: true

RSpec.shared_examples 'a model of state or county' do |model, padding|
  it 'returns a FIPS from a single digit' do
    instance = model.new(fips_code: 9)
    expected_code = '9'.rjust(padding, '0')
    expect(instance.std_fips_code).to eq(expected_code)
  end

  it 'returns a FIPS from double digits' do
    instance = model.new(fips_code: 99)
    expected_code = '99'.rjust(padding, '0')
    expect(instance.std_fips_code).to eq(expected_code)
  end

  it 'returns a FIPS from triple digits' do
    instance = model.new(fips_code: 999)
    expect(instance.std_fips_code).to eq('999')
  end
end
