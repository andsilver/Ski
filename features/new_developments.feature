Feature:
  In order to feature my new development on the new developments page
  As a property developer or estate agent
  I want to flag my property for sale as a new development
  In order to find a new development to buy
  As a property buyer
  I want to view a page that shows only new developments

  Scenario Outline: Property developers, estate agents and administrators see
  new development checkbox on the new property page
    Given I am signed in as a <role>
    When I am on the new property page
    Then I should see "New development"

    Examples:
    | role               |
    | property developer |
    | estate agent       |
    | administrator      |

  Scenario Outline: Advertisers who are neither property developers nor estate
  agents do not see the new property development checkbox
    Given I am signed in as a <role>
    When I am on the new property page
    Then I should not see "New development"

    Examples:
    | role           |
    | property owner |

  Scenario: I can get to the new developments page from the home page
    Given I am on the home page
    When I follow "New Developments"
    Then I should be on the new developments page
    And I should see the "New Developments" heading

  Scenario: I can see new developments on the new developments page
    Given there are 3 new developments
    When I am on the new developments page
    Then I should see 3 new developments

  Scenario: When there are more than 10 new developments they are paginated
    Given there are 11 new developments
    When I am on the new developments page
    Then I should see 10 new developments
    And I should see "Next →"
