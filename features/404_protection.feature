Feature: 404 Hidden or Unavailable Resources

  In order to develop information about countries and resorts without
  visitors or search engine crawlers seeing them, and to encourage
  advertisers to pay to renew their adverts
  As a website owner
  I want a 404 not found response to be sent to visitors of hidden and
  unavailable resources unless signed in as an administrator

  Scenario: Countries are hidden from normal visitors
    Given I am not signed in
    When I visit a country page without visible resorts
    Then I should see a 404 page

  Scenario: Countries are shown to normal visitors
    Given I am not signed in
    When I visit a country page with visible resorts
    Then I should not see a 404 page

  Scenario: Countries are always shown to administrators
    Given I am signed in as an administrator
    When I visit a country page without visible resorts
    Then I should not see a 404 page

  Scenario: Resorts are hidden from normal visitors
    Given I am not signed in
    When I visit an invisible resort page
    Then I should see a 404 page

  Scenario: Resorts are shown to normal visitors
    Given I am not signed in
    When I visit a visible resort page
    Then I should not see a 404 page

  Scenario: Resorts are always shown to administrators
    Given I am signed in as an administrator
    When I visit an invisible resort page
    Then I should not see a 404 page
