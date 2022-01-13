variable "NAME" {
  description = " A name for the secret manager"
  type        = string
}

variable "RETENTION" {
  description = "the number of days that secret manager will maintain the secret before to delete"
  type        = number
}

variable "KMS_KEY" {
  description = "ARN of KMS Key to encrypt the secrets"
  type        = string
}
