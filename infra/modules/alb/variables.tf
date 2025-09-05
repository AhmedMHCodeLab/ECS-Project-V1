variable "project_name" {
  description = "Name of the project"
  type        = string
}

variable "environment" {
  description = "Environment name"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "public_subnet_ids" {
  description = "Public subnet IDs"
  type        = list(string)
}

variable "alb_security_group_id" {
  description = "ALB Security Group ID"
  type        = string
}

variable "domain_name" {
  description = "Domain name"
  type        = string
  default     = ""
}

variable "create_certificate" {
  description = "Whether to create SSL certificate"
  type        = bool
  default     = false
}

variable "certificate_arn" {
  description = "SSL certificate ARN"
  type        = string
  default     = ""
}

variable "enable_https" {
  description = "Enable HTTPS listener"
  type        = bool
  default     = false
}

variable "tags" {
  description = "Common tags"
  type        = map(string)
  default     = {}
}