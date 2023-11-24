When(/^Signed in with (.+)$/) do |prov|
  OmniAuth.config.test_mode = true

  user = {
    'info' => {'name'  => 'Brevin Smider', 'email' => 'brevin@smider.com'},
    'uid' => '1',
    'provider' => ''
  }

  if prov.eql?('GitHub')
    user[:provider] = 'github'
  elsif prov.eql?('Google')
    user[:provider] = 'google_oauth2'
  end

  OmniAuth.config.mock_auth[user[:provider].to_sym] = user
  click_button "Sign in with #{prov}"
end

Given('Logged in') do
  step 'I am on the login page'
  step 'Signed in with Google'
end

Then('Log out') do
  step 'I am on the login page'
  click_link 'Logout'
end

Then('Redirect to home page') do
  expect(page).to have_current_path('/')
end

Then('Redirect to profile page') do
  expect(current_path).to eq user_profile_path
end
