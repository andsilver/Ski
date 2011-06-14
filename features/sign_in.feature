Feature: Sign In

  As an advertiser or administrator
  I want to sign in
  So that I can carry out authenticated activities

  Scenario: Sign in screen presented
    Given I am not signed in
    When I go to the sign in page
    Then I should see "Sign In"
    And I should see "Email"
    And I should see "Password"

  Scenario: My sign in details are correct
    Given I am not signed in
    And I am on the sign in page
    When I fill in "Email" with "bob@mychaletfinder.com"
    And I fill in "Password" with "secret"
    And I press "Sign In"
    Then I should see "Welcome back, Bob"

  Scenario: Both my email address and password are incorrect
    Given I am not signed in
    And I am on the sign in page
    When I fill in "Email" with "nonsense"
    And I fill in "Password" with "wrong"
    And I press "Sign In"
    Then I should see "failed"

  Scenario: My email address is correct but my password is not
    Given I am not signed in
    And I am on the sign in page
    When I fill in "Email" with "bob@mychaletfinder.com"
    And I fill in "Password" with "wrong"
    And I press "Sign In"
    Then I should see "failed"
