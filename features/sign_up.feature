Feature: Sign Up

  As an advertiser
  I want to sign up
  So that MyChaletFinder will remember my details and adverts

  Scenario: Going to the sign up page
    Given I am on the sign in page
    When I follow "sign-up"
    Then I should be on the sign up page

  Scenario: Sign up for a new account
    Given I am on the sign up page
    And I select "Estate agent" from "Account type"
    And I press "Continue"
    When I fill in the following:
      | First name              | Carol                     |
      | Last name               | Cooper                    |
      | Email                   | carol@mychaletfinder.com  |
      | Password                | secret                    |
      | Website                 | http://mychaletfinder.com |
      | House number and street | 1 Main Road               |
      | Town / city             | Hailsham                  |
      | State / county          | East Sussex               |
      | ZIP / postcode          | BN12 12Z                  |
      | Phone                   | +44.1323123456            |
      | Mobile                  | +44.7777123456            |
      | Business name           | Carol's Holidays Ltd      |
      | Your position           | Managing director         |
    And I select "United Kingdom" from "Country"
    And I check "I have read, understood and agree to be bound by the terms and conditions."
    And I press "Register"
    Then I should be on the first advert page
    And I have a new account set up

  Scenario: Password should be at least 5 characters long
    Given I am on the sign up page
    And I select "Estate agent" from "Account type"
    And I press "Continue"
    When I fill in "First name" with "Carol"
    And I fill in "Last name" with "Cooper"
    And I fill in "Email" with "carol@mychaletfinder.com"
    And I fill in "Password" with "1234"
    And I press "Register"
    Then I should be on the users page
    And I should see "Password minimum length is 5 characters"

  Scenario: Email address should be unique
    Given I am on the sign up page
    And I select "Estate agent" from "Account type"
    And I press "Continue"
    When I fill in "First name" with "Bob"
    And I fill in "Last name" with "Brown"
    And I fill in "Email" with "bob@mychaletfinder.com"
    And I fill in "Password" with "secret"
    And I press "Register"
    Then I should be on the users page
    And I should see "Email address has already been taken by an existing customer, please choose another"
