# frozen_string_literal: true

require 'rails_helper'

RSpec.describe NewsItem, type: :model do
  describe 'methods' do
    describe '.find_for' do
      it 'returns a representative_id news item' do
        r = Representative.create(name: 'Brevin', ocdid: '01', title: 'Mayor')
        ni = described_class.create(title: 'News Item', link: 'https://youtube.com', representative: r)
        expect(r.news_items).to include(ni)
        expect(ni.representative).to eq(r)
      end

      it 'returns nil if representative_id has no news item' do
        Representative.create(name: 'Brevin', ocdid: '01', title: 'Mayor')
        found_ni = described_class.find_for(0o1)
        expect(found_ni).to be_nil
      end
    end
  end
end
