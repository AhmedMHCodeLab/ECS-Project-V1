# ACM Certificate
resource "aws_acm_certificate" "main" {
  count = var.create_certificate ? 1 : 0

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
