Feature: Directory Adverts Admin

  In order to maintain site quality
  As the website owner
  I want to be able to edit and delete users' directory adverts

  Scenario: I can reach the directory adverts list from the CMS
    Given I am signed in as an administrator
    When I follow "Directory & Banner Adverts"
    Then I should be on the directory adverts page

  Scenario: Only administrators can see the directory adverts list
    Given I am signed in as an estate agent
    When I am on the directory adverts page
    Then I should be on the sign in page

  Scenario: I should see a list of directory adverts
    Given I am signed in as an administrator
    When I am on the directory adverts page
    Then I should see a list of directory adverts

  Scenario: I can delete a directory advert
    Given I am signed in as an administrator
    And I am on the directory adverts page
    When I delete Monkey Bar
    Then I should be on the directory adverts page
    And Monkey Bar should no longer be there
