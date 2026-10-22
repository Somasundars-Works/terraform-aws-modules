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
