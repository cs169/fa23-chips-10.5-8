# frozen_string_literal: true

require 'rails_helper'
require 'support/shared_examples/fips_code_examples'

RSpec.describe County, type: :model do
  it_behaves_like 'a model of state or county', described_class, 3
end
