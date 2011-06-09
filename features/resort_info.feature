Feature: Resort Info
  In order to increase advertising revenue and sell advertising space
  in the resort's main page
  As the website owner
  I want to be to provide information about the resort to keep the user
  on the page long enough to view the adverts

  Scenario: A tourist can see the resort introductory text
    Given I am on the Chamonix resort info page
    Then I should see "Chamonix, with a population of approximately 10,000"
