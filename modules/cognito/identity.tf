resource "aws_cognito_user_pool" "this" {
  name = var.name

  username_attributes      = ["email"]
  auto_verified_attributes = ["email"]

  password_policy {
    minimum_length                   = 12
    require_lowercase                = true
    require_uppercase                = true
    require_numbers                  = true
    require_symbols                  = true
    temporary_password_validity_days = 3
  }

  account_recovery_setting {
    recovery_mechanism {
      name     = "verified_email"
      priority = 1
    }
  }

  deletion_protection = "ACTIVE"

  tags = {
    Project   = var.name
    ManagedBy = "Terraform"
  }
}

resource "aws_cognito_resource_server" "api" {
  identifier   = var.api_identifier
  name         = "${var.name}-api"
  user_pool_id = aws_cognito_user_pool.this.id

  dynamic "scope" {
    for_each = var.api_scopes

    content {
      scope_name        = scope.key
      scope_description = scope.value
    }
  }
}

resource "aws_cognito_user_group" "this" {
  for_each = var.user_groups

  name         = each.value
  user_pool_id = aws_cognito_user_pool.this.id
  description  = "${each.value} application role"
}

# Browser-based UI: public client, no client secret.
resource "aws_cognito_user_pool_client" "ui" {
  name         = "${var.name}-ui"
  user_pool_id = aws_cognito_user_pool.this.id

  generate_secret = false

  allowed_oauth_flows_user_pool_client = true
  allowed_oauth_flows                  = ["code"]

  allowed_oauth_scopes = merge([
    "openid",
    "email",
    "profile"
  ], var.custom_ui_scopes)

  supported_identity_providers = ["COGNITO"]

  callback_urls = var.callback_urls
  logout_urls   = var.logout_urls

  depends_on = [
    aws_cognito_resource_server.api
  ]

  access_token_validity  = 15
  id_token_validity      = 15
  refresh_token_validity = 7

  token_validity_units {
    access_token  = "minutes"
    id_token      = "minutes"
    refresh_token = "days"
  }

  prevent_user_existence_errors = "ENABLED"
}

# One confidential client per backend service.
resource "aws_cognito_user_pool_client" "machine" {
  for_each = var.machine_clients

  name         = "${var.name}-${each.key}"
  user_pool_id = aws_cognito_user_pool.this.id

  generate_secret = true

  allowed_oauth_flows_user_pool_client = true
  allowed_oauth_flows                  = ["client_credentials"]

  allowed_oauth_scopes = [
    for scope_name in each.value.scopes :
    "${var.api_identifier}/${scope_name}"
  ]

  depends_on = [
    aws_cognito_resource_server.api
  ]
}
resource "aws_cognito_user_pool_domain" "this" {
  domain          = var.custom_domain
  user_pool_id    = aws_cognito_user_pool.this.id
  certificate_arn = aws_acm_certificate_validation.cognito.certificate_arn
}
