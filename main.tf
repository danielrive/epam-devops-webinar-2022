#### Data Sources

data "aws_caller_identity" "ID_CURRENT_ACCOUNT" {}


###  KMS Policy 
data "aws_iam_policy_document" "kms_policy" {
  statement {
    sid    = "Enable IAM User Permissions"
    effect = "Allow"
    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${data.aws_caller_identity.ID_CURRENT_ACCOUNT.account_id}:root"]
    }
    actions = [
      "*"
    ]
    resources = ["*"]

  }
}


##########################
## Secret manager

# KMS ky to encrypt at rest secret manager
module "kms_secret_manager" {
  source = "./modules/kms"
  NAME   = "KMS-SecretManager-${var.environment}"
  POLICY = data.aws_iam_policy_document.kms_policy.json
}

module "secret_manager" {
  source    = "./modules/secret_manager"
  NAME      = "secret_${var.environment}"
  RETENTION = 10
  KMS_KEY   = module.kms_secret_manager.ARN_KMS
}


module "secret_manager_k8" {
  source    = "./modules/secret_manager"
  NAME      = "secret_k8_${var.environment}"
  RETENTION = 10
  KMS_KEY   = module.kms_secret_manager.ARN_KMS
}

resource "aws_s3_bucket" "bucket_test" {
  bucket = "my-bucket-forcompliance-test"

  server_side_encryption_configuration {
    rule {
      /*   
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
      */

      apply_server_side_encryption_by_default {
        kms_master_key_id = module.kms_secret_manager.ARN_KMS
        sse_algorithm     = "aws:kms"
      }


    }

  }

  tags = {
    Name        = "bucket_${var.environment}"
    Environment = "develop"
    Owner       = "DanielR"
  }
}

resource "aws_s3_bucket" "bucket_test2" {
  bucket = "my-bucket-forcompliance-test"

  server_side_encryption_configuration {
    rule {

      apply_server_side_encryption_by_default {
        kms_master_key_id = module.kms_secret_manager.ARN_KMS
        sse_algorithm     = "aws:kms"
      }

    }

  }

  tags = {
    Name        = "bucket_${var.environment}"
    Environment = "develop"
    Owner       = "DanielR"
  }
}


resource "aws_secretsmanager_secret" "secret_manager2" {
  name                    = "test"
  recovery_window_in_days = 10
  lifecycle {
    create_before_destroy = true
  }
  tags = {
    Name        = "test"
    Environment = "develop"
    Owner       = "DanielR"
  }
}