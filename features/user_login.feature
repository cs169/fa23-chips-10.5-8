Feature: User Login
  Scenario: Logging in with Google
    Given I am on the login page
    When Signed in with Google
    Then Redirect to home page

  Scenario: Logging in with Github
    Given I am on the login page
    When Signed in with GitHub
    Then Redirect to home page

  Scenario: Logging out
    Given Logged in
    Then Log out

  Scenario: Can't log in while logged in
    Given Logged in
    When I go to the login page
    Then Redirect to profile page