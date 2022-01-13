Feature:  This test validate if all the resources has the Environment and Owner Tags
Scenario Outline: Ensure that specific tags are defined
    Given I have any resource defined
    When it has tags
    Then it must contain <tags>
    And its value must match the "<value>" regex

Examples:
     | tags | value |
     | Owner | DanielR |
     | Environment | develop |