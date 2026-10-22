# S3 Object Upload

[Back to Home](../../README.md)

Uploads a local file as an object into an existing S3 bucket. The bucket must
already exist and be accessible to the configured AWS identity.

## Usage

```hcl
module "asset" {
  source = "git::https://github.com/Somasundars-Works/terraform-aws-modules.git//modules/S3_upload?ref=main"

  bucket_name  = "example-site-production-us-west-2"
  region       = "us-west-2"
  source_path  = "${path.module}/dist/index.html"
  key          = "index.html"
  etag         = filemd5("${path.module}/dist/index.html")
  content_type = "text/html"
}
```

## Inputs

| Name | Type | Required | Description |
| --- | --- | --- | --- |
| `bucket_name` | `string` | yes | Existing destination bucket |
| `region` | `string` | yes | AWS region |
| `source_path` | `string` | yes | Local path to the file to upload |
| `key` | `string` | yes | Object key in the bucket |
| `etag` | `string` | yes | Change indicator, commonly `filemd5(source_path)` |
| `content_type` | `string` | yes | MIME type set on the object |

This module does not create or configure the destination bucket.
