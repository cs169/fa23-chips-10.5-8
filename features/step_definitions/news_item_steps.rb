# frozen_string_literal: true

Given /On Representative news page/ do
  @representative = Representative.create!({ name: 'Brevin Smider', ocdid: 1 })

  NewsItem.create!(
    {
      representative: @representative,
      link:           'https://berkeley.edu/',
      title:          'CS169',
      description:    'Introduction to Software Engineering'
    }
  )

  visit representative_news_items_path(1)
end

When /Add News Article/ do
  find(:css, 'a.btn.btn-primary', text: 'Add News Article').click
  find(:css, 'button.btn.btn-lg.btn-google.btn-block.text-uppercase.bg-danger.text-white',
       text: 'Sign in with Google').click
  visit representative_new_my_news_item_path(@representative)
end

Then /See Representative/ do
  reps = find('#news_item_representative_id').all('option').map(&:text)
  expect(reps).to include('Brevin Smider')
end
