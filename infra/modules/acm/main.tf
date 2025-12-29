resource "aws_acm_certificate" "this" {
  domain_name       = var.domain_name
  validation_method = "DNS"

  lifecycle {
    create_before_destroy = true
  }

  tags = merge(
    var.tags,
    {
      "Module" = "acm"
    }
  )
}

resource "aws_acm_certificate_validation" "this" {
  certificate_arn = aws_acm_certificate.this.arn

  # Wait for the validation DNS records to be created in Route53
  # This tells Terraform which records to wait for before considering validation complete
  validation_record_fqdns = [
    for record in aws_acm_certificate.this.domain_validation_options : record.resource_record_name
  ]

  timeouts {
    create = "45m"  # Fail after 45 minutes instead of hanging forever
  }
}