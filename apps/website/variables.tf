variable "project_name" {
  type = string
}

variable "environment" {
  type = string
}

variable "region" {
  type = string
}

variable "domain_name" {
  type = string
}

variable "route53_zone_name" {
  description = "Optional Route 53 hosted zone name; defaults to domain_name."
  type        = string
  default     = null
  nullable    = true
}

variable "identity_domain_name" {
  description = "Optional custom domain for the Cognito user pool."
  type        = string
  default     = null
  nullable    = true
}

variable "identity_certificate_arn" {
  description = "Optional pre-existing ACM certificate ARN for the Cognito domain."
  type        = string
  default     = null
  nullable    = true
}
