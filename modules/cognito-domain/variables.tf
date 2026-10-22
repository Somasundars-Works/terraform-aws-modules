variable "user_pool_id" {
  description = "ID of the Cognito user pool to associate with the custom domain."
  type        = string
}

variable "custom_domain" {
  description = "Optional custom Cognito domain, e.g. auth.example.com."
  type        = string
  default     = null
  nullable    = true
}

variable "certificate_arn" {
  description = "ACM certificate ARN for the custom Cognito domain."
  type        = string
  default     = null
  nullable    = true
}

variable "route53_zone_name" {
  description = "Optional Route 53 hosted zone for the custom Cognito domain."
  type        = string
  default     = null
  nullable    = true
}
