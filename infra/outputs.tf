output "vpc_id" {
  description = "VPC ID"
  value       = module.vpc.vpc_id
}

output "alb_dns_name" {
  description = "ALB DNS name"
  value       = module.alb.alb_dns_name
}

output "alb_arn" {
  description = "ALB ARN"
  value       = module.alb.alb_arn
}

output "ecr_repository_url" {
  description = "ECR repository URL"
  value       = module.ecr.repository_url
}

output "ecs_cluster_name" {
  description = "ECS cluster name"
  value       = module.ecs.cluster_name
}

output "application_url" {
  description = "Application URL"
  value       = "https://${var.subdomain}.${local.secret_values.domain_name}"
  sensitive   = true
}

output "certificate_arn" {
  description = "SSL Certificate ARN"
  value       = local.secret_values.certificate_arn
  sensitive   = true
}

output "dns_record" {
  description = "DNS record created"
  value       = "${var.subdomain}.${local.secret_values.domain_name}"
  sensitive   = true
}

output "domain_name" {
  description = "Full domain name"
  value       = "${var.subdomain}.${local.secret_values.domain_name}"
  sensitive   = true
}