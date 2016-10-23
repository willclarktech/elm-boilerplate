Feature: Save Todos
  As a persistent being
  I want to save my todos
  In order to access them later

  Background:
    Given I have a Facebook account
    And I am on the Todos page
    And I have logged in with Facebook
    And I have created 5 Todos

  Scenario: User saves and loads Todos
    When I save my Todos
    And I leave the site
    And I visit the Todos page
    And I log in with Facebook
    Then I should see all of the Todos
