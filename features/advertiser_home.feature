Feature: Advertiser Home

  As an advertiser
  I want to see my account details
  So that I can manage my contact details and advertisements

  Scenario: Advertisers are asked to sign up or sign in
    Given that I am not signed in
    When I go to the advertiser home page
    Then I should see "Sign In"
    But I should not see "My Details"

  Scenario: Advertisers see a link to their details and other features
    Given that I am signed in
    When I go to the advertiser home page
    Then I should see "My Details"
    And I should see "Receipts"
    And I should see "Stats"
    And I should see "My Feedback"
    But I should not see "Sign In"
