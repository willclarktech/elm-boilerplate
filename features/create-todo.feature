Feature: Create Todo
  As a busy inhabitant of the modern world
  I want to create a Todo
  In order to externalise the burden of remembering something I need to do

  Background:
    Given I am on the Todos page

  @critical
  Scenario: New user creates a Todo
    When I create a Todo
    Then I should see the Todo

  Scenario: New user tries to create a blank todo
    When I try to create a blank Todo
    Then I should not see the Todo
