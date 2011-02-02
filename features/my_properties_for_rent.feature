Feature: My Properties for Rent

  As an advertiser
  I would like to see a list of my properties for rent
  So that I can see when my adverts expire and make changes to them

  Scenario: Advertisers see no properties
    Given I am on the my properties for rent page
    When I have no properties for rent
    Then I should see "no properties for rent"
