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

variable "subdomain" {
  description = "Subdomain for the application"
  type        = string
  default     = "threatcomposer"
}

variable "create_route53_record" {
  description = "Whether to create Route 53 DNS record"
  type        = bool
  default     = true
}

variable "create_certificate" {
  description = "Whether to create SSL certificate"
  type        = bool
  default     = false
}

variable "domain_name" {
  description = "Domain name for the application"
  type        = string
  default     = "ahmedmhcodelab.click"
}

variable "hosted_zone_id" {
  description = "Route 53 hosted zone ID"
  type        = string
  default     = "Z02574331F6SOEKH2E2HK"
}

variable "container_image" {
  description = "Container image URI"
  type        = string
  default     = "590183934190.dkr.ecr.us-east-1.amazonaws.com/ecs-threat-composer:latest"
}

variable "certificate_arn" {
  description = "ACM certificate ARN for HTTPS"
  type        = string
  default     = "arn:aws:acm:us-east-1:590183934190:certificate/f2aaf5f8-d097-4982-b029-c9a2a2b0b185"
}
