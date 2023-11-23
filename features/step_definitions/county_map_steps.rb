# frozen_string_literal: true

Given(/^I navigate to the "([A-Z]{2})" state map page$/) do |state|
  visit "/state/#{state}"
end

When('I click on the "Counties in California" button') do 
  click_button('Counties in California')
end

Then('I should see a list of counties') do
  within('#actionmap-state-counties-table') do
    expect(page).to have_css('tbody tr', minimum: 1)
  end
end

And('I can click on the "View" link for the county with FIPS code {string}') do |fips_code|
  find('a.btn.btn-primary[href="/state/CA/county/037"]').click
end

