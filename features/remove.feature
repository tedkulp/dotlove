Feature: We can remove a file from the repository

  Scenario: Remove a .file from the repository
    Given a file named ".somefile" with:
    """
    Some Content Here!!!
    """
    And a working repository
    When I successfully run `dotlove add .somefile`
    And I successfully run `dotlove commit`
    And a file named ".dotfiles/.somefile" should exist
    And a file named ".somefile" is symlinked to ".dotfiles/.somefile"
    When I successfully run `dotlove remove .somefile`
    Then the stdout should contain "File(s) removed from repository"
    And a file named ".dotfiles/.somefile" should not exist

  Scenario: Properly give a message if a file doesn't exist
    Given a working repository
    When I successfully run `dotlove remove .somefile`
    Then the stdout should contain ".somefile - File is not in the repository"
