Feature: Create Todo
  As a busy inhabitant of the modern world
  I want to create a Todo
  In order to externalise the burden of remembering something I need to do

  @now
  @critical
  Scenario: New user creates a Todo
    When I visit the Todos page
    And I create a Todo
    Then I should see the Todo
