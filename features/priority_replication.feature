Feature: priority replication
  We should check that we can give nodes preference during failover

  Scenario: check failover priority 0 prevents leaderships
    Given I configure and start postgres0 with tags {"failover_priority": 1, "nofailover": null}
    And I configure and start postgres1 with tags {"failover_priority": 0, "nofailover": null}
    When I shut down postgres0
    And I sleep for 5 seconds
    Then postgres1 role is the secondary after 10 seconds
    And there is a "following a different leader because I am not allowed to promote" INFO in the postgres1 patroni log
    Given I start postgres0
    Then postgres0 role is the primary after 10 seconds

  Scenario: check higher failover priority is respected
    Given I configure and start postgres2 with tags {"failover_priority": 1, "nofailover": null}
    And I configure and start postgres3 with tags {"failover_priority": 2, "nofailover": null}
    When I shut down postgres0
    Then postgres3 role is the primary after 10 seconds
    And there is a "postgres3 is not lagging and has a higher priority" INFO in the postgres2 patroni log
