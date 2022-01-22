Feature: Logout function of Chat App

    Scenario: Logout notification window
        Given Home Screen with 'Nguyễn Hoàng Long' user
        When I tap Logout button 
        Then Logout notification window will be showed

    Scenario: Logout success
        Given Logout notification window showed
        When I tap 'Yes' button
        Then Logout success and move to Login Screen

    Scenario: Refuse Logout
        Given Logout notification window showed
        When I tap 'No' button
        Then Logout notification window closed and back to Home Screen
