Feature: My Details

  In order to be contacted and billed and to see advertising features of
  interest to me
  As an advertiser
  I want to keep my details up to date

  Scenario: I can reach the my details page from the advertise page
    Given I am signed in
    And I am on the advertise page
    When I follow "My Details"
    Then I should be on the my details page

  Scenario: I should not see the terms & conditions check box
    Given I am signed in
    When I am on the my details page
    Then I should not see "I accept the terms & conditions below"
