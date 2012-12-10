Feature: Categories Admin

  In order to allow advertisers to advertise their business within the
  directory area of the website in a structured manner and thus increase
  advertising revenue
  As the website owner
  I want to be able to create, edit and delete categories

  Scenario: I can get to the new category page from the categories page
    Given I am signed in as an administrator
    And I am on the categories page
    When I follow "Add new category"
    Then I should be on the new category page

  Scenario: Create a new category
    Given I am signed in as an administrator
    And I am on the new category page
    When I fill in "Name" with "Restaurants"
    And I press "Save"
    Then I should see "Created."

  Scenario: Attempt to create an invalid category
    Given I am signed in as an administrator
    And I am on the new category page
    When I press "Save"
    Then I should see "1 error prohibited this category from being saved"

  Scenario: Delete an unwanted category
    Given I am signed in as an administrator
    And there exists a category named "Babysitters"
    And I am on the categories page
    When I follow "Delete Babysitters"
    Then I should see "Deleted."
    And I should not see "Babysitters"
