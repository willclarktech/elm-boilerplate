Feature: Sanity check
  As an app creator
  I want to check that the app loads
  So that I can be confident in basic matters of sanity

  @critical
  Scenario: App loads
    When I visit the Todos page
    Then The page should load
