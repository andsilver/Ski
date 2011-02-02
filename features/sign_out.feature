Feature: Sign out

  As an advertiser or administrator
  I want to be able to sign out
  So that I can be sure that no further access to the site can be gained
  through my browser until I sign back in again, and also so that I can
  sign in using another account if I have one

  Scenario: Sign out when signed in
    Given that I am signed in
    And I am on the home page
    When I follow "sign out"
    Then I am on the home page
    And I should not see "Sign Out"
