Feature: My Properties for Rent

  As an advertiser
  I would like to see a list of my properties for rent
  So that I can see when my adverts expire and make changes to them

  Scenario: Advertisers see no properties
    Given I am signed in
    When I have no properties for rent
    And I am on the my properties for rent page
    Then I should see "no properties for rent"

  Scenario: Advertisers see properties
    Given I am signed in
    When I have properties for rent
    And I am on the my properties for rent page
    Then I should not see "no properties for rent"

  Scenario: Advertisers can go to the new property for rent page
    Given I am signed in
    And I am on the my properties for rent page
    When I follow "new property"
    Then I should be on the new property page

  Scenario: Advertisers can create a new property for rent
    Given I am signed in
    And I am on the new property page
    When I fill in the following:
      | Name               | Chalet Des Sapins              |
      | Strapline          | Excellent facilities, sleeps 4 |
      | Address            | 74400                          |
      | Weekly rent price  | 1650                           |
      | Sleeping capacity  | 4                              |
      | Distance from lift | 1200                           |
      | Number of bedrooms | 2                              |
    And I select "France > Chamonix" from "Resort"
    And I check "Pets allowed"
    And I check "Smoking allowed"
    And I check "TV"
    And I check "WiFi"
    And I check "Suitable for disabled people"
    And I check "Fully equipped kitchen"
    And I check "Parking"
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
    When I am on the my properties for rent page
    And I follow "Chalet Maya"
    Then I should see the "Edit Property" heading
    When I press "Save"
    Then I should see "Your property advert details have been saved."
