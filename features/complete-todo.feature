Feature: Complete Todo
  As a busy inhabitant of the modern world
  I want to complete a Todo
  In order to gain a sense of self-satisfaction

  Background:
    Given I am on the Todos page
    And I have created a todo

  @critical
  Scenario: New user marks a Todo as complete
    When I mark the Todo as complete
    Then I should see that the Todo is completed

  @critical
  Scenario: New user marks a Todo as incomplete
    Given I have marked the todo as complete
    When I mark the Todo as incomplete
    Then I should see that the Todo is not completed
