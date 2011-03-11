Feature:
  In order to feature my new development on the new developments page
  As a property developer
  I want to flag my property for sale as a new development
  In order to find a new development to buy
  As a property buyer
  I want to view a page that shows only new developments

  Scenario: Property developer sees new development checkbox on the
  new property page
    Given I am signed in as a property developer
    When I am on the new property page
    Then I should see "New development"

  Scenario: Non-property developers do not see the new property development
  checkbox
    Given I am signed in but not as a property developer
    When I am on the new property page
    Then I should not see "New development"
