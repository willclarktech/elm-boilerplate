Feature: Second route
  As an explorer
  I want to navigate to a second route
  So that I can expand my horizons

  Background:
    Given I am on the Todos page

  Scenario: Visit info route
    When I visit the info route
    Then I should get some info
