resource "aws_kms_key" "key" {
  description             = "KMS for ${var.NAME}"
  deletion_window_in_days = 10
  tags = {
    Name = "KMS-${var.NAME}"
    Environment = "develop"
    Owner = "DanielR"
  }
}