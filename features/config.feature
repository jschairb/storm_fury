Feature: Provides a config file
  In order to provide some simple config options
  I want StormFury to load a config file
  So I don't have to give all options by hand

  Scenario: When config is missing
    Given a missing config file
    When I run a "storm_fury" command
    Then the output should contain:
    """
    Please create credentials for fog at ~/.fog
    """
