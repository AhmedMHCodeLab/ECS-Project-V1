resource "aws_route53_record" "main" {
  zone_id = local.secret_values.hosted_zone_id
  name    = "${var.subdomain}.${local.secret_values.domain_name}"
  type    = "A"

  alias {
    name                   = module.alb.alb_dns_name
    zone_id                = module.alb.alb_zone_id
    evaluate_target_health = true
  }
}

