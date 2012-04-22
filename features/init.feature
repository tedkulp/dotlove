Feature: We can create a new repository
  If we want to store our dotfiles somewhere,
  we need to creat a place to store them.

  Scenario: Initialize a new repository
    Given a directory named ".dotfiles" doesn't exist
    When I successfully run `dotlove init`
    Then the stdout should contain "Repository Initialized"
    And a directory named ".dotfiles" should exist
    And ".dotfiles" is a valid git repository

  Scenario: Don't re-init a repository
    Given a directory named ".dotfiles"
    When I run `dotlove init`
    Then the stderr should contain "Repository directory already exists"
    And the exit status should not be 0
    And ".dotfiles" is not a valid git repository
