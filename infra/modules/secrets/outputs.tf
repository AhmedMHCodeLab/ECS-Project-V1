output "secret_arn" {
  description = "ARN of the secrets manager secret"
  value       = aws_secretsmanager_secret.app_config.arn
}

output "secret_name" {
  description = "Name of the secrets manager secret"
  value       = aws_secretsmanager_secret.app_config.name
}

output "secret_values" {
  description = "Parsed secret values"
  value       = jsondecode(data.aws_secretsmanager_secret_version.app_config.secret_string)
  sensitive   = true
}
