Feature: Filter Todos
  As a busy todo completer
  I want to filter my todos
  In order to see which todos I’ve completed and which I haven’t

  Background:
    Given I am on the Todos page
    And I have created 5 Todos
    And I have completed 3 Todos

  Scenario: New user filters for completed Todos
    When I filter for completed Todos
    Then I should see the Todos I have completed
    And I should not see the Todos I have not completed

  Scenario: New user filters for incomplete Todos
    When I filter for incomplete Todos
    Then I should see the Todos I have not completed
    And I should not see the Todos I have completed

  Scenario: New user filters for all Todos
    Given I have filtered for completed Todos
    When I filter for all Todos
    Then I should see all of the Todos
