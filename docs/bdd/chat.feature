Feature: Chat function of Chat App

    Scenario: Send Messages Success
        Given Chat screen showed
        When I fill in text field with 'Hello'
        And Tap Send button
        Then The chat bubble with text 'Hello' push to chat screen on the right side

    Scenario: Receive Messages Success
        Given Chat screen showed
        When Your friend fill in text field with 'Hello'
        And Tap Send button
        Then The chat bubble with text 'Hello' push to chat screen on the left side