# Website App

[Back to Home](../../README.md)

Example Terraform root that provisions a versioned private S3 bucket, a
DNS-validated ACM certificate, a CloudFront distribution, and a Route 53 alias.
The ACM certificate for CloudFront is issued in `us-east-1`.

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

## Inputs

| Name | Type | Required | Description |
| --- | --- | --- | --- |
| `project_name` | `string` | yes | Project name used in the bucket name |
| `environment` | `string` | yes | Environment name |
| `region` | `string` | yes | AWS region for the S3 bucket and distribution |
| `domain_name` | `string` | yes | Website custom domain |
| `route53_zone_name` | `string` | no | Hosted zone; defaults to `domain_name` |

The AWS identity needs permissions for S3, CloudFront, ACM, and Route 53. Ensure
the domain's hosted zone exists and is managed by the configured account.

## Use from another repository

In a Terraform root in your application repository, call the website app from
this repository and pass its required inputs:

```hcl
module "website" {
  source = "git::https://github.com/Somasundars-Works/terraform-aws-modules.git//apps/website?ref=main"

  project_name      = "example"
  environment       = "production"
  region            = "us-west-2"
  domain_name       = "www.example.com"
  route53_zone_name = "example.com"
}
```

Then run `terraform init`, `terraform plan`, and `terraform apply` from the
consumer root. Use a tag or commit ref instead of `main` when you need to pin
the app to a specific revision.
