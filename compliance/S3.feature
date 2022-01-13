Feature:  This validates if the s3 buckets has Encryption enabled using KMS
Scenario: Ensure that specific tags are defined
    Given I have aws_s3_bucket resource configured
    When it contain server_side_encryption_configuration
    Then it must have apply_server_side_encryption_by_default
    Then it must have sse_algorithm
    And its value must be "aws:kms"
    
    