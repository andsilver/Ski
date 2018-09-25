Feature: Tourist

  In order to find a chalet with and near to facilities I want
  As a tourist
  I want to search through properties to rent

  Scenario: Browse a list of countries
    Given I am on the home page
    Then I should see "France"
    And I should see "Italy"
    And I should see "Austria"
    And I should see "Switzerland"
    But I should not see "United Kingdom"

  Scenario: Select a country to see a list of resorts
    Given I am on the home page
    When I follow "France"
    Then I should see "Chamonix"

  Scenario: Select a resort to see a list of browse options
    Given I am on the home page
    When I follow "France"
    And I follow "Chamonix"
    Then I should see "Holiday Rentals"
    And I should see "For Sale"
    And I should see "Directory"
    And I should see "Resort Info"

  Scenario: Get to and browse a list of properties for rent in a resort
    Given I am on the home page
    When I follow "France"
    And I follow "Chamonix"
    And I follow "Holiday Rentals"
    Then I should see "Alpen Lounge"

  Scenario: See rental details
    Given I am on the Chamonix Properties for Rent page
    Then I should see "Weekly price"
    And I should see weekly rent prices
    And I should see "sleeps"
    But I should not see "Sale price"

  Scenario: See sale details
    Given I am on the Chamonix Properties for Sale page
    Then I should see "Sale price"
    And I should see sale prices
    But I should not see "Weekly rent price"
    And I should not see "sleeps"

  Scenario: View more details about a property for rent
    Given I am on the Chamonix Properties for Rent page
    When I follow "Read more about Alpen Lounge"
    Then I should be on the Alpen Lounge page
    And I should see the "Alpen Lounge" heading
    And I should see "The Alpen Lounge is a 100 square meter self catering chalet."

  Scenario: Be told when there are no properties for rent
    Given I am on the Italian Alps Properties for Rent page
    Then I should see "There are no properties advertised at this resort"

  Scenario: Browse the directory
    Given I am on the Chamonix directory page
    And there are bars advertised in Chamonix
    When I follow "Bars"
    Then I should see the "Bars in Chamonix" heading
    And I should see a list of bars in Chamonix
