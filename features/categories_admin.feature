Feature: Categories Admin

  In order to allow advertisers to advertise their business within the
  directory area of the website in a structured manner and thus increase
  advertising revenue
  As the website owner
  I want to be able to create, edit and delete categories

  Scenario: I can get to the new category page from the Chamonix directory
  page
    Given I am signed in as an administrator
    And I am on the Chamonix directory page
    When I follow "Add new category"
    Then I should be on the new Chamonix category page

  Scenario: Create a new category
    Given I am signed in as an administrator
    And I am on the new Chamonix category page
    When I fill in "Name" with "Restaurants"
    And I select "France > Chamonix" from "Resort"
    And I press "Save"
    Then I should see "Category created."

  Scenario: Attempt to create an invalid category
    Given I am signed in as an administrator
    And I am on the new Chamonix category page
    When I press "Save"
    Then I should see "1 error prohibited this category from being saved"
