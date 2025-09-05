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
  default     = ""
}

variable "subdomain" {
  description = "Subdomain for the application"
  type        = string
  default     = "tm"
}

variable "create_certificate" {
  description = "Whether to create SSL certificate"
  type        = bool
  default     = false
}

variable "create_route53_record" {
  description = "Whether to create Route 53 DNS record"
  type        = bool
  default     = false
}

variable "hosted_zone_id" {
  description = "Route 53 hosted zone ID"
  type        = string
  default     = ""
}

variable "container_image" {
  description = "Container image URI"
  type        = string
  default     = "590183934190.dkr.ecr.us-east-1.amazonaws.com/ecs-threat-composer:latest"
}
