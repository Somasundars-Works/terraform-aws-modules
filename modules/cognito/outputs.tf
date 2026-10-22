output "ui_client_id" {
  description = "Public UI app client ID."
  sensitive   = true
  value       = aws_cognito_user_pool_client.ui.id
}

output "machine_client_ids" {
  description = "App client IDs for backend services."
  sensitive   = true
  value = {
    for name, client in aws_cognito_user_pool_client.machine :
    name => client.id
  }
}
