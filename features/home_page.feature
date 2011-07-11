Feature: Home Page

  Scenario: Admin can change home page content
    Given I am signed in as an administrator
    And I am on the Website CMS page
    And I fill in "Home content" with "Welcome!"
    And I press "Update Website"
    When I am on the home page
    Then I should see "Welcome!"
