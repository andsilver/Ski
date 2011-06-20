Feature: My Properties for Rent

  As an advertiser
  I would like to see a list of my properties for rent
  So that I can see when my adverts expire and make changes to them

  Scenario: Advertisers see no properties
    Given I am signed in
    When I have no properties for rent
    And I am on the my adverts page
    Then I should not see "Chalet Azimuth"

  Scenario: Advertisers see properties
    Given I am signed in
    When I have properties for rent
    And I am on the my adverts page
    Then I should see "Chalet Azimuth"

  Scenario: Advertisers can go to the new property for rent page
    Given I am signed in
    And I am on the advertise page
    When I follow "New Property for Rent"
    Then I should be on the new property page

  Scenario: Advertisers can create a new property for rent
    Given I am signed in
    And I am on the new property page
    When I fill in the following:
      | Property name             | Chalet Des Sapins              |
      | Strapline                 | Excellent facilities, sleeps 4 |
      | Address                   | 74400                          |
      | Weekly rent price         | 1650                           |
      | Distance from town centre | 800                            |
      | Nearest lift              | 500                            |
    And I select "France > Chamonix" from "Resort"
    And I select "4" from "Sleeping capacity"
    And I select "2" from "Number of bedrooms"
    And I select "Freeview" from "TV"
    And I select "No parking" from "Parking"
    And I check "Pets allowed"
    And I check "Smoking allowed"
    And I check "WiFi"
    And I check "Disabled access"
    And I check "Fully equipped kitchen"
    And I press "Save"
    Then my new property for rent has been saved
    And I should be on the new image page
    And I should see "Your property advert was successfully created."

  Scenario: Advertisers see error messages when property details are invalid
    Given I am signed in
    And I am on the new property page
    When I press "Save"
    Then I should see "errors prohibited this property from being saved"

  Scenario: Advertisers can edit properties
    Given I am signed in
    And I have properties for rent
    When I am on the my adverts page
    And I follow "Chalet Maya"
    Then I should see the "Edit Property" heading
    When I press "Save"
    Then I should see "Your property advert details have been saved."
