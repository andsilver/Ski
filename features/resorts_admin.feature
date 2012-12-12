Feature: Resorts Administration

  Resorts are the key geographic grouping for properties and businesses.
  Visitors want to find out more about resorts and meanwhile they will
  be drawn into the adverts within the information.
  As the website owner
  I want to be able to create, edit and delete categories.

  Scenario: See a table of resorts
    Given I am signed in as an administrator
    When I am on the resorts page
    Then I should see a table of resorts
    And I should see resorts that are not visible to the public

  Scenario: Easily edit meta for intro, guide, gallery and piste map pages
    Given I am signed in as an administrator
    And Chamonix has meta pages for intro, guide, gallery and piste map
    When I am on the edit resort page for Chamonix
    Then I should see links to edit intro, guide, gallery and piste map meta
