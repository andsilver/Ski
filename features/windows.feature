Feature: Advertising Windows

  In order to optimise the display of a number of properties through the year
  As an advertiser
  I would like to manage my properties in windows which are advertising
  spaces that I can swap properties into and out of at any time, for example
  if I let or sell a property I can put another in its place at no extra cost

  Scenario: I have an opportunity to buy advertising windows from my account
    Given I am signed in as an estate agent
    And I am on the advertise page
    When I follow "Buy Advertising Windows"
    Then I should be on the buy windows adverts page

  Scenario: Private property owners don't get to buy advertising windows
    Given I am signed in as a property owner
    When I am on the advertise page
    Then I should not see "Buy Advertising Windows"

  Scenario: I should be able to buy more properties windows from the basket
    Given I am signed in as an estate agent
    And I am on the basket page
    When I follow "buy more advertising windows"
    Then I should be on the buy windows adverts page
