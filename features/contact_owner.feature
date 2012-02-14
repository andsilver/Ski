Feature: Contact Owner

  In order to express my interest in renting or buying the property
  and ask further questions that I may have
  As a tourist
  I want to contact the owner of a property

  Scenario: Contact owner of a property for rent
    Given I am on the Chamonix Properties for Rent page
    And I follow "Alpen Lounge"
    And I follow "Enquire"
    When I fill in the following:
      | Name         | Natalie           |
      | Email        | nat@example.org   |
      | Phone        | +44.7777123456    |
      | Comments     | Are pets welcome? |
    And I press "Send"
    Then I should see "Thank you for enquiring about this property"

  Scenario: Contact owner of a property for sale
    Given I am on the Chamonix Properties for Sale page
    And I follow "Chalet Alaska"
    When I follow "Enquire"
    Then I should not see "Date of arrival"
    And I should not see "Date of departure"
    And I should not see "Number of adults"
    And I should not see "Number of children"
    And I should not see "Number of infants"
