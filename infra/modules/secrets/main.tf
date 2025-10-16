resource "aws_secretsmanager_secret" "app_config" {
  name        = "${var.project_name}-${var.environment}-config"
  description = "Application configuration secrets"

  tags = var.tags
}

resource "aws_secretsmanager_secret_version" "app_config" {
  secret_id = aws_secretsmanager_secret.app_config.id

  secret_string = jsonencode({
    certificate_arn = var.certificate_arn
    container_image = var.container_image
    domain_name     = var.domain_name
    hosted_zone_id  = var.hosted_zone_id
  })

  lifecycle {
    ignore_changes = [secret_string]
  }
}

data "aws_secretsmanager_secret_version" "app_config" {
  secret_id  = aws_secretsmanager_secret.app_config.id
  depends_on = [aws_secretsmanager_secret_version.app_config]
}
