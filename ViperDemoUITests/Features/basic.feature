Feature: Basic

Background:
Given I launched the app

Scenario: Basic
Then I should see NewsTableView

When I touch NewsCell0

Then I should see NewsDetailsWebView
