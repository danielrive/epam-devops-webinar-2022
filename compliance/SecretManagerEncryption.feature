Feature:  This validate if the secret manager created has encryption with KMS enabled
Scenario: Ensure that Secret Manager has KMS
    Given I have aws_secretsmanager_secret defined
    Then it must contain kms_key_id