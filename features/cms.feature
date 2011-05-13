Feature: CMS

  In order to maintain the website and instil confidence in larger customers
  As a website owner
  I want a professional, presentable and functional CMS that will allow me to
  manage the website and demonstrate how we manage the business and how
  versatile the site is in terms of updating it

  Scenario: Administrators get sent the the CMS home page on signing in
    Given I am signed in as an administrator
    Then I should be on the cms page
