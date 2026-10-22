# Identity App

[Back to Home](../../README.md)

Example Terraform root that provisions a Cognito user pool and UI client. A
custom Cognito domain is optional. When `identity_domain_name` is set without
`identity_certificate_arn`, this app requests and DNS-validates an ACM
certificate; when both are set, it uses the supplied certificate.

## Configure and validate

Run Terraform from this directory and provide AWS credentials through the AWS
CLI profile or standard AWS environment variables.

```sh
terraform init
terraform validate
terraform plan \
  -var='project_name=example' \
  -var='environment=production' \
  -var='region=us-west-2' \
  -var='domain_name=www.example.com' \
  -var='route53_zone_name=example.com'
```

To configure a custom sign-in domain, add:

```sh
-var='identity_domain_name=auth.example.com'
```

Alternatively, also pass a pre-existing certificate ARN:

```sh
-var='identity_domain_name=auth.example.com' \
-var='identity_certificate_arn=arn:aws:acm:us-east-1:123456789012:certificate/example-id'
```

## Inputs

| Name | Type | Required | Description |
| --- | --- | --- | --- |
| `project_name` | `string` | yes | Project name prefix |
| `environment` | `string` | yes | Environment name |
| `region` | `string` | yes | Cognito user pool AWS region |
| `domain_name` | `string` | yes | Website host used for callback and logout URLs and default hosted zone |
| `route53_zone_name` | `string` | no | Hosted zone; defaults to `domain_name` |
| `identity_domain_name` | `string` | no | Optional custom Cognito domain |
| `identity_certificate_arn` | `string` | no | Optional existing ACM certificate ARN |

## Outputs

| Name | Description |
| --- | --- |
| `identity_user_pool_id` | Cognito user pool ID |
| `identity_ui_client_id` | Public UI app client ID (sensitive) |
| `identity_domain` | Assigned custom domain, or `null` if not configured |

For a custom Cognito domain, the ACM certificate must be in `us-east-1`. The AWS
identity needs permissions for Cognito and, when applicable, ACM and Route 53.

## Use from another repository

In a Terraform root in your application repository, call the identity app from
this repository. Set the optional domain and certificate inputs when needed:

```hcl
module "identity" {
  source = "git::https://github.com/Somasundars-Works/terraform-aws-modules.git//apps/identity?ref=main"

  project_name      = "example"
  environment       = "production"
  region            = "us-west-2"
  domain_name       = "www.example.com"
  route53_zone_name = "example.com"

  # Optional custom Cognito domain:
  # identity_domain_name = "auth.example.com"
  #
  # Optional pre-existing ACM certificate for that domain:
  # identity_certificate_arn = "arn:aws:acm:us-east-1:123456789012:certificate/example-id"
}
```

Run `terraform init`, `terraform plan`, and `terraform apply` from the consumer
root. Use a tag or commit ref instead of `main` to pin the app to a specific
revision.
