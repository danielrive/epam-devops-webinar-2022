Feature:  This validate if the secret manager created has encryption with KMS enabled
Scenario: Ensure that Secret Manager has KMS
    Given I have aws_secretsmanager_secret resource configured
    Then it must contain recovery_window_in_days
    And its value must be 10