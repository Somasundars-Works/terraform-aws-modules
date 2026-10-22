variable "domain_name" {
  description = "Custom domain name to point at CloudFront."
  type        = string
}

variable "route53_zone_name" {
  description = "Route 53 hosted zone containing the custom domain."
  type        = string
}

variable "cloudfront_domain_name" {
  description = "CloudFront distribution domain name."
  type        = string
}

variable "cloudfront_hosted_zone_id" {
  description = "CloudFront distribution hosted zone ID."
  type        = string
}
