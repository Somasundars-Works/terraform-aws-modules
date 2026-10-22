# Terraform AWS Modules

[![Terraform validation](https://github.com/Somasundars-Works/terraform-aws-modules/actions/workflows/terraform-validate.yaml/badge.svg?branch=main)](https://github.com/Somasundars-Works/terraform-aws-modules/actions/workflows/terraform-validate.yaml)

Reusable Terraform modules and example application roots for AWS infrastructure.

## Modules

| Module | Purpose |
| --- | --- |
| [S3](./modules/S3/README.md) | Versioned private website bucket |
| [S3 upload](./modules/S3_upload/README.md) | Upload an object to an existing S3 bucket |
| [ACM](./modules/acm/README.md) | DNS-validated ACM certificate |
| [CloudFront](./modules/cloudfront/README.md) | CloudFront distribution and S3 origin access |
| [CloudFront domain](./modules/cloudfront-domain/README.md) | Route 53 alias for a CloudFront distribution |
| [Cognito](./modules/cognito/README.md) | Cognito user pool, app clients, groups, and scopes |
| [Cognito domain](./modules/cognito-domain/README.md) | Optional Cognito custom domain and Route 53 alias |

## Apps

| App | Purpose |
| --- | --- |
| [Website](./apps/website/README.md) | S3-backed static website with CloudFront and a custom domain |
| [Identity](./apps/identity/README.md) | Cognito identity service with optional custom domain |

## Use from another repository

Call a module from a consumer Terraform root using its Git source and
subdirectory. For example:

```hcl
module "website_bucket" {
  source = "git::https://github.com/Somasundars-Works/terraform-aws-modules.git//modules/S3?ref=main"

  project_name = "example"
  environment  = "production"
  region       = "us-west-2"
}
```

The [website app](./apps/website/README.md) and
[identity app](./apps/identity/README.md) also have complete consumer-root
examples. Run `terraform init` in the consumer root to fetch the source. Replace
`main` with a tag or commit ref to pin the source to a specific revision.

## Validate locally

Terraform 1.14.6 and AWS provider 6.70.0 are used by the GitHub Actions
validation workflow. Supply AWS credentials using the AWS CLI profile or
standard AWS environment variables.

```sh
terraform fmt -check -recursive
terraform -chdir=apps/website init -backend=false
terraform -chdir=apps/website validate
terraform -chdir=apps/identity init -backend=false
terraform -chdir=apps/identity validate
```

The [Terraform validation workflow](./.github/workflows/terraform-validate.yaml)
runs formatting checks and validates every module and app directory on pull
requests and pushes to `main`. Its **Terraform Validation Status** job provides
a single status check to use in branch protection rules.
