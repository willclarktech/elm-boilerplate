Feature: Login with Facebook
  As a social creature
  I want to login
  So that I can perform my various identities

  Background:
    Given I have a Facebook account
    And I am on the Todos Page

  Scenario: Facebook user logs in
    When I log in with Facebook
    Then I should be logged in
