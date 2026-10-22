variable "region" { type = string }
variable "domain_name" { type = string }

variable "route53_zone_name" {
  description = "Optional Route 53 hosted zone name; defaults to the certificate domain."
  type        = string
  default     = null
  nullable    = true
}
