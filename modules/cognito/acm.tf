resource "aws_acm_certificate" "cognito" {
  provider          = aws.us_east_1
  domain_name       = var.custom_domain
  validation_method = "DNS"
}

resource "aws_route53_record" "cognito_certificate_validation" {
  count = 1

  zone_id         = data.aws_route53_zone.domain.zone_id
  name            = tolist(aws_acm_certificate.cognito.domain_validation_options)[count.index].resource_record_name
  type            = tolist(aws_acm_certificate.cognito.domain_validation_options)[count.index].resource_record_type
  records         = [tolist(aws_acm_certificate.cognito.domain_validation_options)[count.index].resource_record_value]
  ttl             = 60
  allow_overwrite = true
}

resource "aws_acm_certificate_validation" "cognito" {
  provider                = aws.us_east_1
  certificate_arn         = aws_acm_certificate.cognito.arn
  validation_record_fqdns = aws_route53_record.cognito_certificate_validation[*].fqdn
}
