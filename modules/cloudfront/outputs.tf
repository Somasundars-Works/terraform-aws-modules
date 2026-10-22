output "distribution_domain_name" {
  description = "CloudFront distribution domain name."
  value       = aws_cloudfront_distribution.cloudfront_distribution.domain_name
}

output "distribution_hosted_zone_id" {
  description = "CloudFront distribution hosted zone ID."
  value       = aws_cloudfront_distribution.cloudfront_distribution.hosted_zone_id
}
