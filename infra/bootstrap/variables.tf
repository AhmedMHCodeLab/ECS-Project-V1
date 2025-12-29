variable "aws_region" {
  description = "AWS region for state bucket"
  type        = string
  default     = "us-east-1"
}

variable "state_bucket_prefix" {
  description = "S3 bucket prefix for Terraform state (random suffix will be added)"
  type        = string
  default     = "ecs-tc-tfstate"

  validation {
    condition     = can(regex("^[a-z0-9][a-z0-9-]*[a-z0-9]$", var.state_bucket_prefix))
    error_message = "Bucket prefix must be lowercase alphanumeric with hyphens"
  }
}

variable "lock_table_name" {
  description = "DynamoDB table name for state locking"
  type        = string
  default     = "ecs-threat-composer-terraform-locks"
}
