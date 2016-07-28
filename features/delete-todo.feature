@now
Feature: Delete Todo
  As a fallible human being
  I want to delete a Todo
  In order to address a duplication

  Background:
    Given I am on the Todos page
    And I have created a todo

  @critical
  Scenario: New user deletes a Todo
    When I delete the Todo
    Then I should not see the Todo
