Feature: Basket

  In order to purchase many items together and so not have to repeatedly
  enter my credit card number at the payment gateway and receive multiple
  receipts and have multiple orders
  As an advertiser
  I want to be able to add my adverts to a basket and checkout with multiple
  adverts

  Scenario: My basket is empty
    Given I am signed in
    And I have no adverts in my basket
    When I am on the basket page
    Then I should see "Your basket is empty."

  Scenario: I have adverts in my basket
    Given I am signed in
    And I have adverts in my basket
    When I am on the basket page
    Then I should see my adverts
