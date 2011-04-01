Feature: Admin Bar

  In order to administer the website
  As an administrator
  I want to be able to get to website admin pages from any page

  Scenario: Admin bar shows on the home page
    Given I am signed in as an administrator
    When I am on the home page
    Then I should see a link to "Coupons"
    And I should see a link to "Resorts"
    And I should see a link to "Orders"
    And I should see a link to "Users"
