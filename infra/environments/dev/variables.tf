variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "project_name" {
  description = "Name of the project"
  type        = string
  default     = "ecs-threat-composer"
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "dev"
}

variable "domain_name" {
  description = "Domain name for the application"
  type        = string
  default     = "tc.ahmedmhcodelab.click"
}


variable "parent_domain_name" {
  description = "Parent domain name registered with Route53 Domains (e.g., ahmedmhcodelab.click). Used for nameserver and NS delegation automation."
  type        = string
  default     = "ahmedmhcodelab.click"
}
