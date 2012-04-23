@announce
Feature: We can add a file to the repository

  Scenario: Newly added files will commit correctly
    Given a file named ".somefile" with:
    """
    Some Content Here!!!
    """
    And a working repository
    When I successfully run `dotlove add .somefile`
    And I successfully run `dotlove commit`
    Then a file named ".somefile" is not staged to be committed in ".dotfiles"
    And a file named ".somefile" is committed in ".dotfiles"
    And the stdout should contain "File(s) committed"

  Scenario: Older files that have been changed will commit correctly
    Given a file named ".somefile" with:
    """
    Some Content Here!!!
    """
    And a working repository
    When I successfully run `dotlove add .somefile`
    And I successfully run `dotlove commit`
    Then a file named ".somefile" is committed in ".dotfiles"
    When I overwrite ".somefile" with:
    """
    Some Other Content Here!!!
    """
    And I successfully run `dotlove commit`
    Then a file named ".somefile" is not staged to be committed in ".dotfiles"
    And a file named ".somefile" is committed in ".dotfiles"
    And the stdout should contain "File(s) committed"
    And git should have contain "Other" in the file ".somefile" in ".dotfiles"
