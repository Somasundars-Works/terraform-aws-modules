# CloudFront Distribution

[Back to Home](../../README.md)

Creates a CloudFront distribution with an existing S3 bucket as its origin,
restricts S3 reads to the distribution's origin access identity, and configures
the supplied ACM certificate and alternate domain name. It does not create DNS
records; use the [CloudFront domain module](../cloudfront-domain/README.md) for
that.

## Usage

```hcl
module "distribution" {
  source = "git::https://github.com/Somasundars-Works/terraform-aws-modules.git//modules/cloudfront?ref=main"

  region              = "us-west-2"
  domain_name         = "www.example.com"
  bucket_name         = "example-site-production-us-west-2"
  acm_certificate_arn = module.certificate.certificate_arn
}
```

## Inputs

| Name | Type | Required | Description |
| --- | --- | --- | --- |
| `region` | `string` | yes | Region value supplied by the caller |
| `domain_name` | `string` | yes | Alternate domain name on the distribution |
| `bucket_name` | `string` | yes | Existing S3 origin bucket |
| `acm_certificate_arn` | `string` | yes | ACM certificate ARN in `us-east-1` |

## Outputs

| Name | Description |
| --- | --- |
| `distribution_domain_name` | AWS-assigned CloudFront domain |
| `distribution_hosted_zone_id` | Hosted zone ID for the CloudFront alias target |

The bucket must exist before applying this module.
