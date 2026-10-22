variable "name" {
  description = "Name prefix for the identity infrastructure."
  type        = string
}

variable "domain_prefix" {
  description = "Globally unique Cognito hosted-domain prefix."
  type        = string
}

variable "callback_urls" {
  description = "Allowed UI login callback URLs."
  type        = list(string)
  default     = []
}

variable "logout_urls" {
  description = "Allowed UI logout URLs."
  type        = list(string)
  default     = []
}

variable "api_identifier" {
  description = "OAuth resource server identifier."
  type        = string
  default     = "identity-api"
}

variable "api_scopes" {
  description = "Custom OAuth scopes exposed by the API."
  type        = map(string)

  default = {
    "orders.read"  = "Read orders"
    "orders.write" = "Create or update orders"
    "orders.admin" = "Administrative order operations"
  }
}

variable "user_groups" {
  description = "Application groups used for user role assignment."
  type        = set(string)
  default     = ["Administrators", "Users"]
}

variable "machine_clients" {
  description = "Confidential OAuth clients for backend services."
  type = map(object({
    scopes = set(string)
  }))

  default = {}
}

variable "custom_domain" {
  description = "Custom Cognito domain, e.g. auth.example.com"
  type        = string
}

variable "route53_zone_name" {
  description = "Parent Route 53 hosted zone name"
  type        = string
}

variable "custom_ui_scopes" {
  description = "Custom OAuth scopes for the UI client."
  type        = list(string)
  default     = []
}
