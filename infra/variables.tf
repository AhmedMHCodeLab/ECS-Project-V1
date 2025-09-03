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

variable "create_certificate" {
  description = "Whether to create SSL certificate"
  type        = bool
  default     = false
}

variable "container_image" {
  description = "Container image URI"
  type        = string
  default     = "590183934190.dkr.ecr.us-east-1.amazonaws.com/ecs-threat-composer:latest"
}
