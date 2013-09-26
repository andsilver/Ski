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
    When I follow "Advertise a Property for Rent"
    Then I should be on the new property page

  Scenario: Advertisers see error messages when property details are invalid
    Given I am signed in
    And I am on the new property page
    When I press "Save"
    Then I should see "errors prohibited this property from being saved"

  Scenario: Advertisers can edit properties
    Given I am signed in
    And I have properties for rent
    When I am on the my adverts page
    And I follow "Edit Chalet Maya"
    Then I should see the "Edit Property" heading
    When I press "Save"
    Then I should see "Your property advert details have been saved."
