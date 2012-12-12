Feature: Resorts Administration

  Resorts are the key geographic grouping for properties and businesses.
  Visitors want to find out more about resorts and meanwhile they will
  be drawn into the adverts within the information.
  As the website owner
  I want to be able to create, edit and delete categories.

  Scenario: See a table of resorts
    Given I am signed in as an administrator
    And I am on the resorts page
    Then show me the page
    Then I should see a table of resorts
    And I should see resorts that are not visible to the public
