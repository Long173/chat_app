Feature: Register function of Chat App

    Scenario: Register Success
        Given A register screen is showed when tap into text 'Register' in Login Screen
        And The database is clean
        When I fill "Full Name" with "Nguyễn Hoàng Long"
        And I fill "Email" with "q9nhoclong@gmail.com"
        And I fill "Password" with "123456"
        And I fill "Confirm Password" with "123456"
        And I press "Register"
        Then Register success and move to Login Screen

    Scenario: Register Fail with email existed
        Given A register screen is showed when tap into text 'Register' in Login Screen
        And The database has email 'q9nhoclong@gmail.com'
        When I fill "Full Name" with "Nguyễn Hoàng Long"
        And I fill "Email" with "q9nhoclong@gmail.com"
        And I fill "Password" with "123456"
        And I fill "Confirm Password" with "123456"
        And I press "Register"
        Then Register fail and message 'Email already exists' will be showed

    Scenario: Register Fail with password is too short
        Given A register screen is showed when tap into text 'Register' in Login Screen
        And The database is clean
        When I fill "Full Name" with "Nguyễn Hoàng Long"
        And I fill "Email" with "q9nhoclong@gmail.com"
        And I fill "Password" with "123"
        And I fill "Confirm Password" with "123"
        And I press "Register"
        Then Register fail and message 'Password must be more than 6 characters' will be showed

    Scenario: Register Fail with confirm password is not match
        Given A register screen is showed when tap into text 'Register' in Login Screen
        And The database is clean
        When I fill "Full Name" with "Nguyễn Hoàng Long"
        And I fill "Email" with "q9nhoclong@gmail.com"
        And I fill "Password" with "123456"
        And I fill "Confirm Password" with "123456789"
        And I press "Register"
        Then Register fail and message 'Confirm Password is not match' will be showed

    Scenario: Register Fail with email invalidate
        Given A register screen is showed when tap into text 'Register' in Login Screen
        And The database is clean
        When I fill "Full Name" with "Nguyễn Hoàng Long"
        And I fill "Email" with "q9nhoclong"
        And I fill "Password" with "123456"
        And I fill "Confirm Password" with "123456"
        And I press "Register"
        Then Register fail and message 'Email invalidate' will be showed