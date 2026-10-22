# CloudFront Domain

[Back to Home](../../README.md)

Creates a Route 53 A-record alias that points a custom domain at an existing
CloudFront distribution. The distribution and its ACM certificate are managed
separately by the [CloudFront module](../cloudfront/README.md).

## Usage

```hcl
module "website_domain" {
  source = "git::https://github.com/Somasundars-Works/terraform-aws-modules.git//modules/cloudfront-domain?ref=main"

  domain_name                 = "www.example.com"
  route53_zone_name           = "example.com"
  cloudfront_domain_name      = module.distribution.distribution_domain_name
  cloudfront_hosted_zone_id   = module.distribution.distribution_hosted_zone_id
}
```

## Inputs

| Name | Type | Required | Description |
| --- | --- | --- | --- |
| `domain_name` | `string` | yes | DNS name to create |
| `route53_zone_name` | `string` | yes | Existing Route 53 hosted zone |
| `cloudfront_domain_name` | `string` | yes | Distribution domain name |
| `cloudfront_hosted_zone_id` | `string` | yes | Distribution hosted zone ID |

The caller's AWS identity needs permission to read the hosted zone and manage
Route 53 records.
