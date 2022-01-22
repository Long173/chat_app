Feature: Login function of Chat App

    Scenario: Login Success
        Given A login screen is showed
        When I fill "Email" with "q9nhoclong@gmail.com"
        And I fill "Password" with "123456"
        And I press "Login"
        Then Login success and move to home screen

    Scenario: Login Fail with not exist email
        Given A login screen is showed
        When I fill "Email" with "asdasdg@gmail.com"
        And I fill "Password" with "123456"
        And I press "Login"
        Then Login fail and message "Email is not exist" will be showed

    Scenario: Login Fail with wrong password
        Given A login screen is showed
        When I fill "Email" with "q9nhoclong@gmail.com"
        And I fill "Password" with "123456789"
        And I press "Login"
        Then Login fail and message "Password is wrong" will be showed
