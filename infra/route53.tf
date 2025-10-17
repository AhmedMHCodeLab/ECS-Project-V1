# Create hosted zone for parent domain
resource "aws_route53_zone" "parent" {
  name = var.parent_domain_name

  tags = {
    Project     = var.project_name
    Environment = var.environment
    ManagedBy   = "Terraform"
    Type        = "Parent"
  }
}

# Automatically update nameservers for the registered domain
# This updates the Route53 Domains registration to use the new parent hosted zone nameservers
resource "aws_route53domains_registered_domain" "main" {
  domain_name = var.parent_domain_name

  dynamic "name_server" {
    for_each = aws_route53_zone.parent.name_servers
    content {
      name = name_server.value
    }
  }

  depends_on = [aws_route53_zone.parent]
}

# Create hosted zone for subdomain (depends on parent zone to ensure correct order)
resource "aws_route53_zone" "main" {
  name = var.domain_name

  depends_on = [aws_route53domains_registered_domain.main]

  tags = {
    Project     = var.project_name
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}

# Delegate subdomain to the new hosted zone (NS record in parent zone)
resource "aws_route53_record" "subdomain_ns" {
  zone_id = aws_route53_zone.parent.zone_id
  name    = var.domain_name
  type    = "NS"
  ttl     = 300
  records = aws_route53_zone.main.name_servers

  depends_on = [aws_route53_zone.main]
}

# A record pointing to the ALB
resource "aws_route53_record" "app" {
  zone_id = aws_route53_zone.main.zone_id
  name    = var.domain_name
  type    = "A"

  alias {
    name                   = module.alb.alb_dns_name
    zone_id                = module.alb.alb_zone_id
    evaluate_target_health = true
  }
}

# ACM validation records (automated)
resource "aws_route53_record" "acm_validation" {
  for_each = {
    for dvo in module.acm.certificate_domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      type   = dvo.resource_record_type
      record = dvo.resource_record_value
    }
  }
  zone_id = aws_route53_zone.main.zone_id
  name    = each.value.name
  type    = each.value.type
  ttl     = 300
  records = [each.value.record]
}
