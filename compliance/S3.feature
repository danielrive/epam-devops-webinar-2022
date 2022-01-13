Feature:  This validates if the s3 buckets has Encryption enabled using KMS
Scenario: Ensure that specific tags are defined
    Given I have aws_s3_bucket defined
    Then it must contain server_side_encryption_configuration
    
    