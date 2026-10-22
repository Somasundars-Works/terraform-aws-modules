resource "aws_route53_record" "cognito" {
  zone_id = data.aws_route53_zone.domain.zone_id
  name    = var.custom_domain
  type    = "A"

  alias {
    name                   = aws_cognito_user_pool_domain.this.cloudfront_distribution
    zone_id                = aws_cognito_user_pool_domain.this.cloudfront_distribution_zone_id
    evaluate_target_health = false
  }
}
