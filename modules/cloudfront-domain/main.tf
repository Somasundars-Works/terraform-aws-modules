terraform {
  required_version = ">= 1.3"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.70.0"
    }
  }
}

data "aws_route53_zone" "domain_zone" {
  name = var.route53_zone_name
}
