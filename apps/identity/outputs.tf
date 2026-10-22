output "identity_user_pool_id" {
  description = "Cognito user pool ID."
  value       = module.identity.user_pool_id
}

output "identity_ui_client_id" {
  description = "Cognito UI app client ID."
  value       = module.identity.ui_client_id
  sensitive   = true
}

output "identity_domain" {
  description = "Cognito custom domain, or null when it is not configured."
  value       = module.identity_domain.domain
}
