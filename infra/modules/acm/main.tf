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

# Wait for certificate validation to complete
# Note: DNS validation records are created in the root route53.tf file
resource "aws_acm_certificate_validation" "this" {
  certificate_arn = aws_acm_certificate.this.arn
  
  # We don't specify validation_record_fqdns here because the records
  # are created outside this module (in route53.tf)
  # ACM will automatically detect the validation records in Route53
}