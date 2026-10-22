# S3 Website Bucket

[Back to Home](../../README.md)

Creates a versioned S3 bucket for website assets and blocks public access.
CloudFront access is granted by the separate CloudFront module.

## Usage

```hcl
module "website_bucket" {
  source = "git::https://github.com/Somasundars-Works/terraform-aws-modules.git//modules/S3?ref=main"

  project_name = "example"
  environment  = "production"
  region       = "us-west-2"
}
```

## Inputs

| Name | Type | Required | Description |
| --- | --- | --- | --- |
| `project_name` | `string` | yes | Project prefix used in the bucket name |
| `environment` | `string` | yes | Environment suffix |
| `region` | `string` | yes | AWS region used in the bucket name and provider |

## Outputs

| Name | Description |
| --- | --- |
| `website_bucket` | ID/name of the created bucket |

The bucket name is assembled as `<project_name>-site-<environment>-<region>`.
It must be globally unique within S3.
