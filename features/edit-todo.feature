Feature: Edit Todo
  As a fallible human being
  I want to edit a todo
  In order to correct a mistake or update in the the light of new information

  Background:
    Given I am on the Todos page
    And I have created a todo

  @critical
  Scenario: New user edits a Todo
    When I edit the Todo
    Then I should see that the Todo is updated
