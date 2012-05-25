Feature: Favourites

  In order to continue browsing other properties and not forget ones that
  interested me earlier
  As a visitor to the website
  I want to be able to save and revisit favourite properties

  Scenario: I can add a property to my favourites list
    Given I am on the Alpen Lounge page
    When I press "Add to Favourites"
    Then I should see "Property has been added to your favourites"
    When I follow "Favourites"
    Then I should see "Alpen Lounge"

  Scenario: I can remove a property from my favourites list
    Given I am on the Alpen Lounge page
    And I press "Add to Favourites"
    And I follow "Favourites"
    When I press "Remove from Favourites"
    Then I should see "Property has been removed from your favourites."
