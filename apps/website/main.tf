module "certificate" {
  source = "../../modules/acm"

  region            = var.region
  domain_name       = var.domain_name
  route53_zone_name = var.route53_zone_name

  providers = {
    aws = aws.us_east_1
  }
}

module "bucket" {
  source = "../../modules/S3"

  project_name = var.project_name
  environment  = var.environment
  region       = var.region
}

module "cloudfront" {
  depends_on = [module.certificate, module.bucket]

  source = "../../modules/cloudfront"

  region              = var.region
  domain_name         = var.domain_name
  bucket_name         = module.bucket.website_bucket
  acm_certificate_arn = module.certificate.certificate_arn
}

module "cloudfront_domain" {
  source = "../../modules/cloudfront-domain"

  domain_name               = var.domain_name
  route53_zone_name         = var.route53_zone_name != null ? var.route53_zone_name : var.domain_name
  cloudfront_domain_name    = module.cloudfront.distribution_domain_name
  cloudfront_hosted_zone_id = module.cloudfront.distribution_hosted_zone_id
}
