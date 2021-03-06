Feature: Admin approve charity admin
  As an Admin
  So that I can approve someone to be able to make edits for a particular charity
  (assumed charity admin has requested access to become charity admin and email has been sent)
  I want to be able to verify the organisation/user and give them access to their charity.

  Background:
    Given the following organizations exist:
      | name            | address        |
      | My Organization | 83 pinner road |

    And the following users are registered:
      | email              | password       | admin | confirmed_at        | organization    | pending_organization |
      | nonadmin@myorg.com | mypassword1234 | false | 2008-01-01 00:00:00 |                 |                      |
      | admin@myorg.com    | adminpass0987  | true  | 2008-01-01 00:00:00 | My Organization |                      |
      | pending@myorg.com  | password123    | false | 2008-01-01 00:00:00 |                 | My Organization      |


  Scenario: As an admin approving a pending user's request
    Given I am signed in as an admin
    When I approve "pending@myorg.com"
    Then "pending@myorg.com" is a charity admin of "My Organization"

  Scenario: As a non-admin trying to access users index
    Given I am signed in as a non-admin
    And I visit "/users"
#    Then show me the page
    Then I should be on the home page
    And I should see "You must be signed in as an admin to perform this action!"

