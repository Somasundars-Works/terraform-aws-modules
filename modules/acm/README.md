# ACM Certificate

[Back to Home](../../README.md)

Requests an ACM certificate and completes DNS validation using Route 53. The
AWS provider configured by the caller determines the certificate region.
CloudFront viewer certificates must be created in `us-east-1`.

## Usage

```hcl
provider "aws" {
  region = "us-east-1"
  alias  = "us_east_1"
}

module "certificate" {
  source = "git::https://github.com/Somasundars-Works/terraform-aws-modules.git//modules/acm?ref=main"

  region            = "us-east-1"
  domain_name       = "www.example.com"
  route53_zone_name = "example.com"

  providers = {
    aws = aws.us_east_1
  }
}
```

## Inputs

| Name | Type | Required | Description |
| --- | --- | --- | --- |
| `region` | `string` | yes | Region value supplied by the caller |
| `domain_name` | `string` | yes | Certificate domain name |
| `route53_zone_name` | `string` | no | Hosted zone to use; defaults to `domain_name` |

## Outputs

| Name | Description |
| --- | --- |
| `certificate_arn` | ARN returned after DNS validation completes |

The configured AWS identity needs permission to request/describe certificates
and create Route 53 records in the selected hosted zone.
