Feature: Sign Up

  As an advertiser
  I want to sign up
  So that MySkiChalet will remember my details and adverts

  Scenario: Going to the sign up page
    Given I am on the sign in page
    When I follow "Sign Up"
    Then I should be on the sign up page

  Scenario: Sign up for a new account
    Given I am on the sign up page
    When I fill in "Name" with "Carol"
    And I fill in "Email" with "carol@myskichalet.co.uk"
    And I fill in "Password" with "secret"
    And I press "Sign Up"
    Then I should be on the my details page
    And I have a new account set up
