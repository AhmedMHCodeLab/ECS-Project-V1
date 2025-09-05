resource "aws_acm_certificate" "existing" {
  domain_name       = "${var.subdomain}.${var.domain_name}"
  validation_method = "DNS"
  
  lifecycle {
    ignore_changes = all
    prevent_destroy = true
  }
}

locals {
  certificate_arn = aws_acm_certificate.existing.arn
}
