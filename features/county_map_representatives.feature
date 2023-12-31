Feature: search county representatives
  As a user
  I want to select a county on the map
  So that I can see a list of all representatives of that county

@load-seed-data
Scenario: User selects Los Angeles County to view its representatives
  Given I navigate to the "CA" state map page
  When I click on the Counties in "California" button
  Then I should see a list of counties
  When I click on the "View" link for the county with county name "Los Angeles County"
  Then I should be taken to the search page for county "Los Angeles County"
  Then I should see a list of representatives

