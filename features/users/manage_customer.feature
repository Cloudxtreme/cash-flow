Feature: Manage Customer
  In order to manage customers
  As an admin
  So I can sign them up for a plan

  Background:
    Given I am logged in as an admin
    And I am on the customers admin page

  Scenario: I create a customer
    When I click 'New Customer'
    Then  I should see 'New customer'
    When I fill in the following:
      | First name                     | John |
      | Last name                      | Smith |
      | Email                          | johnsmith@memail.com |
    And I press "Create"
    Then I should be on the "users" page
    And I should see a successful sign up message