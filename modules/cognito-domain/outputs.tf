output "domain" {
  description = "The assigned Cognito custom domain, or null when not configured."
  value       = try(aws_cognito_user_pool_domain.this[0].domain, null)
}
