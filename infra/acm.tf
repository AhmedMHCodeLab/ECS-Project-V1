# ACM Certificate
resource "aws_acm_certificate" "main" {
  count = var.create_certificate ? 1 : 0

  domain_name       = "${var.subdomain}.${var.domain_name}"
  validation_method = "DNS"

  subject_alternative_names = [
    "*.${var.domain_name}"
  ]

  tags = local.common_tags

  lifecycle {
    create_before_destroy = true
  }
}

# Certificate validation records
resource "aws_route53_record" "cert_validation" {
  count = var.create_certificate && var.create_route53_record ? 1 : 0

  for_each = {
    for dvo in aws_acm_certificate.main[0].domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
  zone_id         = data.aws_route53_zone.main[0].zone_id

  depends_on = [aws_acm_certificate.main]
}

# Certificate validation
resource "aws_acm_certificate_validation" "main" {
  count = var.create_certificate && var.create_route53_record ? 1 : 0

  certificate_arn         = aws_acm_certificate.main[0].arn
  validation_record_fqdns = [for record in aws_route53_record.cert_validation[0] : record.fqdn]

  timeouts {
    create = "10m"
  }

  depends_on = [aws_route53_record.cert_validation]
}
