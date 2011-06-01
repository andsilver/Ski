Feature: Contact Owner

  In order to express my interest in renting or buying the property
  and ask further questions that I may have
  As a tourist
  I want to contact the owner of a property

  Scenario: Contact owner
    Given I am on the Chamonix Properties for Rent page
    And I follow "Alpen Lounge"
    And I follow "Contact Owner"
    When I fill in the following:
      | Name         | Natalie           |
      | Email        | nat@example.org   |
      | Phone        | +44.7777123456    |
      | Comments     | Are pets welcome? |
    And I press "Send"
    Then I should see "Your enquiry has been sent."
