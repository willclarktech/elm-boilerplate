Feature: Complete Todo
  As a busy inhabitant of the modern world
  I want to complete a Todo
  In order to gain a sense of self-satisfaction

  @critical
  Scenario: New user completes a Todo
    Given I am on the Todos page
    And I have created a todo
    When I complete the Todo
    Then I should see that the Todo is completed
