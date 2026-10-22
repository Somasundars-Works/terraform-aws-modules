locals {
  create_custom_domain = var.custom_domain != null && var.certificate_arn != null
  create_dns_record    = local.create_custom_domain && var.route53_zone_name != null
}

data "aws_route53_zone" "domain" {
  count = local.create_dns_record ? 1 : 0

  name = var.route53_zone_name
}

resource "aws_cognito_user_pool_domain" "this" {
  count = local.create_custom_domain ? 1 : 0

  domain          = var.custom_domain
  user_pool_id    = var.user_pool_id
  certificate_arn = var.certificate_arn
}

resource "aws_route53_record" "cognito" {
  count = local.create_dns_record ? 1 : 0

  zone_id = data.aws_route53_zone.domain[0].zone_id
  name    = var.custom_domain
  type    = "A"

  alias {
    name                   = aws_cognito_user_pool_domain.this[0].cloudfront_distribution
    zone_id                = aws_cognito_user_pool_domain.this[0].cloudfront_distribution_zone_id
    evaluate_target_health = false
  }
}
