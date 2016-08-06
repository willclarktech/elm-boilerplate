Feature: Login with Facebook
  As a social creature
  I want to login
  So that I can perform my various identities

  Background:
    Given I have a Facebook account
    And I am on the Todos page

  Scenario: Facebook user logs in
    When I log in with Facebook
    Then I should be greeted by name
