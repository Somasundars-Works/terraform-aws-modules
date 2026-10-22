# Cognito Identity

[Back to Home](../../README.md)

Creates a Cognito user pool with email sign-in, a public browser client,
configurable user groups and OAuth scopes, and optional machine-to-machine
clients. This module does not create a hosted domain. Use the
[Cognito domain module](../cognito-domain/README.md) separately if needed.

## Usage

```hcl
module "identity" {
  source = "git::https://github.com/Somasundars-Works/terraform-aws-modules.git//modules/cognito?ref=main"

  name          = "example-production"
  callback_urls = ["https://www.example.com/callback"]
  logout_urls   = ["https://www.example.com/logout"]

  user_groups = ["Administrators", "Users"]
  machine_clients = {
    billing = {
      scopes = ["orders.read"]
    }
  }
}
```

## Inputs

| Name | Type | Required | Description |
| --- | --- | --- | --- |
| `name` | `string` | yes | User pool and client name prefix |
| `callback_urls` | `list(string)` | no | UI client callback URLs; defaults to `[]` |
| `logout_urls` | `list(string)` | no | UI client logout URLs; defaults to `[]` |
| `api_identifier` | `string` | no | Resource server identifier; defaults to `identity-api` |
| `api_scopes` | `map(string)` | no | OAuth scope names and descriptions |
| `user_groups` | `set(string)` | no | User pool groups; defaults to Administrators and Users |
| `machine_clients` | `map(object({ scopes = set(string) }))` | no | Confidential client definitions; defaults to `{}` |
| `custom_ui_scopes` | `list(string)` | no | Additional scopes for the UI client; defaults to `[]` |

## Outputs

| Name | Description |
| --- | --- |
| `user_pool_id` | Cognito user pool ID |
| `ui_client_id` | Public UI app client ID (sensitive) |
| `machine_client_ids` | Map of machine-client names to IDs (sensitive) |

The user pool enforces a 12-character password minimum with lowercase,
uppercase, numeric, and symbol requirements, and has deletion protection enabled.
