Feature: We can add a file to the repository

  Scenario: Add a new .file to the repository
    Given a file named ".somefile" with:
    """
    Some Content Here!!!
    """
    And a working repository
    When I successfully run `dotlove add .somefile`
    Then the stdout should contain "File(s) added to repository"
    And the stdout should contain ".somefile - OK"
    And a file named ".dotfiles/.somefile" should exist
    And a file named ".somefile" is symlinked to ".dotfiles/.somefile"
    When I run `dotlove add .somefile`
    Then the stdout should contain "File(s) added to repository"
    And the stdout should contain ".somefile - Already Added"
    And a file named ".dotfiles/.somefile" should exist
    And a file named ".somefile" is symlinked to ".dotfiles/.somefile"

  Scenario: Add multiple files to the repository
    Given a file named ".somefile" with:
    """
    Some Content Here!!!
    """
    And a file named ".anotherfile" with:
    """
    More stuff!!!
    """
    And a working repository
    When I successfully run `dotlove add .somefile .anotherfile`
    Then the stdout should contain "File(s) added to repository"
    And the stdout should contain ".somefile - OK"
    And the stdout should contain ".anotherfile - OK"
    And a file named ".dotfiles/.somefile" should exist
    And a file named ".somefile" is symlinked to ".dotfiles/.somefile"
    And a file named ".dotfiles/.anotherfile" should exist
    And a file named ".anotherfile" is symlinked to ".dotfiles/.anotherfile"
