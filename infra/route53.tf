# Data source to get existing hosted zone
data "aws_route53_zone" "main" {
  count = var.create_route53_record ? 1 : 0
  
  zone_id = var.hosted_zone_id != "" ? var.hosted_zone_id : null
  name    = var.hosted_zone_id == "" ? var.domain_name : null
}

# Route 53 A record pointing to ALB
resource "aws_route53_record" "main" {
  count = var.create_route53_record ? 1 : 0
  
  zone_id = data.aws_route53_zone.main[0].zone_id
  name    = "${var.subdomain}.${var.domain_name}"
  type    = "A"

  alias {
    name                   = module.alb.alb_dns_name
    zone_id                = module.alb.alb_zone_id
    evaluate_target_health = true
  }

  depends_on = [module.alb]
}
