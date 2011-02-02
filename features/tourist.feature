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
