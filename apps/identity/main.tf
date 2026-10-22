module "identity_certificate" {
  count = var.identity_domain_name != null && var.identity_certificate_arn == null ? 1 : 0

  source = "../../modules/acm"

  region            = var.region
  domain_name       = var.identity_domain_name
  route53_zone_name = var.route53_zone_name != null ? var.route53_zone_name : var.domain_name

  providers = {
    aws = aws.us_east_1
  }
}

module "identity" {
  source = "../../modules/cognito"

  name = "${var.project_name}-${var.environment}"

  callback_urls = ["https://${var.domain_name}/callback"]
  logout_urls   = ["https://${var.domain_name}/logout"]

  providers = {
    aws = aws
  }
}

module "identity_domain" {
  depends_on = [module.identity_certificate, module.identity]

  source = "../../modules/cognito-domain"

  user_pool_id  = module.identity.user_pool_id
  custom_domain = var.identity_domain_name

  certificate_arn = var.identity_certificate_arn != null ? var.identity_certificate_arn : (
    var.identity_domain_name != null ? module.identity_certificate[0].certificate_arn : null
  )

  route53_zone_name = var.identity_domain_name != null ? (
    var.route53_zone_name != null ? var.route53_zone_name : var.domain_name
  ) : null

  providers = {
    aws = aws
  }
}
