data "aws_route53_zone" "domain" {
  name = var.route53_zone_name
}
