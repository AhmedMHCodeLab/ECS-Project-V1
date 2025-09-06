# ACM Certificate Management
# We're using a variable to specify an existing certificate ARN instead of creating one
# This simplifies certificate management and avoids validation issues

locals {
  # Use the certificate ARN from variables
  certificate_arn = var.certificate_arn
}
