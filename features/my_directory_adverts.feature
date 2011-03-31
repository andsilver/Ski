Feature: My Directory Adverts

  In order to see when my adverts expire and make changes to them
  As an advertiser
  I would like to see a list of my directory adverts

  Scenario: I can get to My Directory Adverts from Advertiser Home
    Given I am signed in as an other business
    And I am on the advertiser home page
    When I follow "My Directory Adverts"
    Then I should be on the my directory adverts page
    And I should see the "My Directory Adverts" heading

  Scenario: I can get to the new directory advert page from My Directory
  Adverts
    Given I am signed in
    And I am on the my directory adverts page
    When I follow "New Directory Advert"
    Then I should be on the new directory advert page

  Scenario: I can see a list of my directory adverts in My Directory Adverts
    Given I am signed in
    And I have directory adverts
    And my business is called "Chambre Neuf"
    When I am on the my directory adverts page
    Then I should see "Chambre Neuf"
    But I should not see "no directory adverts"

  Scenario: I see no directory adverts
    Given I am signed in
    And I have no directory adverts
    And my business is called "Chambre Neuf"
    When I am on the my directory adverts page
    Then I should see "no directory adverts"
    But I should not see "Chambre Neuf"

  Scenario: Create a new directory advert
    Given I am signed in
    And I am on the new directory advert page
    When I select "France > Chamonix > Bars" from "Category"
    And I fill in "Business Address" with "272, av Michel Croz"
    And I fill in "ZIP / Postcode" with "74400"
    And I press "Save"
    Then I should see "Your directory advert was successfully created."
