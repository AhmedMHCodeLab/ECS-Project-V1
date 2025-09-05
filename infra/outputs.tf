output "vpc_id" {
  description = "VPC ID"
  value       = module.vpc.vpc_id
}

output "alb_dns_name" {
  description = "ALB DNS name"
  value       = module.alb.alb_dns_name
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
  value = var.create_route53_record ? (
    var.create_certificate ? 
    "https://${var.subdomain}.${var.domain_name}" : 
    "http://${var.subdomain}.${var.domain_name}"
  ) : (
    var.create_certificate ? 
    "https://${module.alb.alb_dns_name}" : 
    "http://${module.alb.alb_dns_name}"
  )
}

output "certificate_arn" {
  description = "SSL Certificate ARN"
  value       = var.create_certificate ? aws_acm_certificate_validation.main[0].certificate_arn : ""
}

output "dns_record" {
  description = "DNS record created"
  value       = var.create_route53_record ? "${var.subdomain}.${var.domain_name}" : ""
}