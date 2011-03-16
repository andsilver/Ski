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

  Scenario: Countries have flags
    Given I am on the home page
    Then I should see the French, Italian, Austrian and Swiss flags

  Scenario: Select a country to see a list of resorts
    Given I am on the home page
    When I follow "France"
    Then I should see "Chamonix"

  Scenario: Select a resort to see a list of browse options
    Given I am on the home page
    When I follow "France"
    And I follow "Chamonix"
    Then I should see "Properties for Rent"
    And I should see "Properties for Sale"
    And I should see "Directory"
    And I should see "Resort Info"

  Scenario: Browse a list of properties for rent in a resort
    Given I am on the home page
    When I follow "France"
    And I follow "Chamonix"
    And I follow "Properties for Rent in Chamonix"
    Then I should see "Alpen Lounge"

  Scenario: View more details about a property for rent
    Given I am on the Chamonix Properties for Rent page
    When I follow "Alpen Lounge"
    Then I should be on the Alpen Lounge page
    And I should see the "Alpen Lounge" heading

  Scenario: Be told when there are no properties for rent
    Given I am on the Italian Alps Properties for Rent page
    Then I should see "There are no properties advertised for rent at this resort."

  Scenario: Browse the directory
    Given I am on the Chamonix directory page
    And there are bars advertised in Chamonix
    When I follow "Bars"
    Then I should see the "Bars in Chamonix" heading
    And I should see a list of bars in Chamonix
