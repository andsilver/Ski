Feature: My Directory Adverts

  In order to see when my adverts expire and make changes to them
  As an advertiser
  I would like to see a list of my directory adverts

  Scenario: I can get to the new directory advert page from my account
    Given I am signed in as an other business
    And I am on the advertise page
    When I follow "New Directory Advert"
    Then I should be on the new directory advert page

  Scenario: I can see a list of my directory adverts in My Directory Adverts
    Given I am signed in as an other business
    And I have directory adverts
    And my business is called "Chambre Neuf"
    When I am on the my adverts page
    Then I should see "Chambre Neuf"

  Scenario: I see no directory adverts
    Given I am signed in as an other business
    And I have no directory adverts
    And my business is called "Chambre Neuf"
    When I am on the my adverts page
    Then I should not see "Chambre Neuf"

  Scenario: Create a new directory advert
    Given I am signed in as an other business
    And I am on the new directory advert page
    When I select "Bars" from "Category"
    And I select "France > Chamonix" from "Resort"
    And I fill in "Business address" with "272, av Michel Croz"
    And I fill in "ZIP / postcode" with "74400"
    And I press "Save"
    Then I should see "Your directory advert was successfully created."
