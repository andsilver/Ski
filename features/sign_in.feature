Feature: Sign In

  As an advertiser or administrator
  I want to sign in
  So that I can carry out authenticated activities

  Scenario: Sign in screen presented
    Given that I am not signed in
    When I go to the sign in page
    Then I should see "Sign In"

  Scenario: My sign in details are incorrect
    Given that I am not signed in
    And I am on the sign in page
    When I fill in "Email" with "nonsense"
    And I press "Sign In"
    Then I get redirected
    And I should see "failed"
