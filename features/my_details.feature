Feature: My Details

  As an advertiser
  I want to see my account details
  So that I can manage my contact details and advertisements

  Scenario: Advertisers are asked to sign up or log in
    Given that I am not logged in
    When I go to the my details page
    Then I should see "login"
    But I should not see "My Details"

  Scenario: Advertisers see their details
    Given that I am logged in
    When I go to the my details page
    Then I should see "My Details"
    But I should not see "login"
