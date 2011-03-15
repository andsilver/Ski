Feature:

  In order to keep contact details correct and current
  As a website owner
  I want a summary of the advertiser's details to appear whilst creating a
  new advert so that they will be reminded to update their details if
  necessary

  Scenario: Summary of details are shown
    Given I am signed in
    When I am on the new property page
    Then I should see a summary of my details and an option to edit

  Scenario: There is a link to edit details
    Given I am signed in
    And I am on the new property page
    When I follow "Edit my details"
    Then I should be on the my details page
