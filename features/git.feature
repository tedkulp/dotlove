Feature: We can run arbitrary git commands

  Scenario: We want to see the current status of the repo
    Given a file named ".somefile" with:
    """
    Some Content Here!!!
    """
    And a working repository
    When I successfully run `dotlove add .somefile`
    And I successfully run `dotlove git status --porcelain`
    Then the stdout should contain "A  .somefile"
