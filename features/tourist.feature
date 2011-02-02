Feature: Tourist

  As a tourist
  I want to search through properties to rent
  So that I can find a chalet with and near to facilities I want

  Scenario: Browse a list of countries
    Given I am on the home page
    Then I should see "France"
    And I should see "Italy"
    And I should see "Austria"
    And I should see "Switzerland"

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
