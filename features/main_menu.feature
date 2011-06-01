Feature: Main Menu

  Pages should feature a main menu with links to the most significant
  areas of the website

  Scenario: Home page
    Given I am on the home page
    Then I should see "Sign In"
    And I should see "Register"
    And I should see "Advertise"

  Scenario: Sign out
    Given I am signed in
    When I am on the home page
    Then I should see "Sign Out"
