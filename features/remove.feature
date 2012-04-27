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
    And the stdout should contain ".somefile - Removed"
    And a file named ".dotfiles/.somefile" should not exist

  Scenario: Properly give a message if a file doesn't exist
    Given a working repository
    When I successfully run `dotlove remove .somefile`
    Then the stdout should contain ".somefile - File is not in the repository"

  Scenario: Properly remove multiple files from the repository
    Given a file named ".somefile" with:
    """
    Some Content Here!!!
    """
    And a file named ".otherfile" with:
    """
    Some Content Here!!!
    """
    And a working repository
    When I successfully run `dotlove add .somefile .otherfile`
    And I successfully run `dotlove commit`
    When I successfully run `dotlove remove .somefile .otherfile`
    Then the stdout should contain "File(s) removed from repository"
    And the stdout should contain ".somefile - Removed"
    And the stdout should contain ".otherfile - Removed"
    And a file named ".dotfiles/.somefile" should not exist
    And a file named ".dotfiles/.otherfile" should not exist
