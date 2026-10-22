# Cognito Domain

[Back to Home](../../README.md)

Optionally assigns a custom domain to an existing Cognito user pool and
optionally creates its Route 53 alias. The domain resource is created only when
both `custom_domain` and `certificate_arn` are provided. The DNS alias is
created only when `route53_zone_name` is also provided.

## Usage

```hcl
module "identity_domain" {
  source = "git::https://github.com/Somasundars-Works/terraform-aws-modules.git//modules/cognito-domain?ref=main"

  user_pool_id       = module.identity.user_pool_id
  custom_domain      = "auth.example.com"
  certificate_arn    = module.certificate.certificate_arn
  route53_zone_name  = "example.com"
}
```

Omit `custom_domain` or `certificate_arn` to leave the Cognito hosted domain
unassigned. Omit `route53_zone_name` to assign the Cognito domain without
creating a Route 53 record.

## Inputs

| Name | Type | Required | Description |
| --- | --- | --- | --- |
| `user_pool_id` | `string` | yes | Existing Cognito user pool ID |
| `custom_domain` | `string` | no | Optional custom Cognito domain |
| `certificate_arn` | `string` | no | ACM certificate ARN for the custom domain |
| `route53_zone_name` | `string` | no | Hosted zone for the optional alias |

## Outputs

| Name | Description |
| --- | --- |
| `domain` | Assigned custom domain, or `null` when not configured |

For a custom Cognito domain, the certificate must meet AWS Cognito's region and
domain requirements; use `us-east-1` for the ACM certificate.
