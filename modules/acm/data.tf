data "aws_route53_zone" "domain_zone" {
  name = var.route53_zone_name != null ? var.route53_zone_name : var.domain_name
}
