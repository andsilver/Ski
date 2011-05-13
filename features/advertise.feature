Feature: Advertise

  In order to manage my contact details and advertisements
  As an advertiser
  I want to see my account details

  Scenario: Advertisers are asked to sign up or sign in
    Given I am not signed in
    When I go to the advertise page
    Then I should see "Please sign in or sign up first."

  Scenario: Advertisers see a link to their details and other features
    Given I am signed in
    When I go to the advertise page
    Then I should see the "Advertise" heading
    And I should see "My Details"
    And I should see "Receipts"
    And I should see "Stats"
    And I should see "My Feedback"
    And I should see "My Enquiries"
    But I should not see "Sign In"

  Scenario: Advertisers can go to the My Details page
    Given I am signed in
    And I am on the advertise page
    When I follow "My Details"
    Then I should see the "My Details" heading

  Scenario: Advertisers can go to the my adverts page
    Given I am signed in as a property owner
    And I am on the advertise page
    When I follow "My Adverts"
    Then I should be on the my adverts page
