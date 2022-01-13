resource "aws_secretsmanager_secret" "secret_manager" {
  name                    = var.NAME
  recovery_window_in_days = var.RETENTION
  lifecycle {
    create_before_destroy = true
  }
  tags = {
    Name = var.NAME
    Environment = "develop"
    Owner = "DanielR"
  }
  kms_key_id = var.KMS_KEY
}