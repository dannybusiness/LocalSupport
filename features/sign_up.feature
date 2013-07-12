Feature: Sign in
  As an new User
  So that I can add charities to the list and make a page for my own charity
  I want to be able to create a login
  Tracker story ID: https://www.pivotaltracker.com/story/show/47373595

Background:
Given the following users are registered:
| email             | password |
| existent-user@example.com | pppppppp |

Scenario: Sign up for an existing user
  Given I am on the sign up page
  And I sign up as "existent-user@example.com" with password "pppppppp" and password confirmation "pppppppp"
  Then I should see "Email has already been taken"
  And it should not send me an email
  
Scenario: Sign up for a non-existent user
  Given I am on the sign up page
  And I sign up as "non-existent-user@example.com" with password "pppppppp" and password confirmation "pppppppp"
  Then I should be on the home page
  And I should see "A message with a confirmation link has been sent to your email address. Please open the link to activate your account."
  And it should send me a "registration confirmation" email

Scenario: Click on sign up link

Scenario: Sign up for an non-existent user with non-matching password confirmation
  Given I am on the sign up page
  And I sign up as "existent-user@example.com" with password "pppppppp" and password confirmation "aaaaaaaa"
  Then I should see "Password doesn't match confirmation"
  And it should not send me an email
  
