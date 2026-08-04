# tf-azurerm-module_primitive-postgresql_server

[![License](https://img.shields.io/badge/License-Apache_2.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)
[![License: CC BY-NC-ND 4.0](https://img.shields.io/badge/License-CC_BY--NC--ND_4.0-lightgrey.svg)](https://creativecommons.org/licenses/by-nc-nd/4.0/)

## Overview

This module deploys an Azure Database for PostgreSQL Flexible Server.

## Usage

See [examples/complete](examples/complete) for a full working example.

## Module Development

### Pre-Requisites

The following commands should be available on your system:

- `asdf` or `mise`
- `make`
- `python3` (for pre-commit)

Additionally, your `git` user and email must be configured. Run the `make configure` command from the root of the repository to ensure that you meet these requirements.

### Pre-Commit hooks

The [.pre-commit-config.yaml](.pre-commit-config.yaml) file defines `pre-commit` hooks for Terraform formatting, validation, documentation generation, and detect-secrets. Hooks are installed when you run `make configure`. Go linting runs via `make lint` in local development and CI, not via pre-commit.

### Terratest examples

Post-deploy tests in `tests/post_deploy_functional/` and `tests/post_deploy_functional_readonly/` target `examples/complete` via an explicit folder constant in each `main_test.go`. Adding another example (for example `examples/minimal`) requires a new test entry point or updating that constant; it is not picked up automatically.

### Local Validation

You should validate the changes you make to any module locally, prior to pushing your changes in a branch to GitHub.

1. Ensure that you have run `make configure` successfully.
2. Ensure you are signed into the appropriate cloud provider (e.g. Azure) for the module under test in your current console session.
3. Run the Terraform and Golang linters:

```
make lint
```

4. Once linters pass, run integration tests (apply, test, destroy):

```
make test
```

The pre-commit validations, as well as the `make lint` and `make test` targets, are performed in CI. Running them locally before opening a PR helps ensure a smooth review.

### Review & Merge Process

Open a Pull Request to the default (`main`) branch. The PR title must follow [Conventional Commits](https://www.conventionalcommits.org/en/v1.0.0/#specification) format to merge and to drive semantic versioning.

Ensure CI workflows pass, address review feedback, and obtain approvals required by `CODEOWNERS`.

### Automatic Updates

Shared configuration and workflow files are largely managed through [launch-terraform-skeleton](https://github.com/launchbynttdata/launch-terraform-skeleton). Avoid one-off edits to copied skeleton files in this repository unless necessary (for example `.gitignore` entries for generated artifacts). Use `copier check-update` / `copier update` when refreshing from the skeleton.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.3 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 3.113 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_postgresql_flexible_server.postgres](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/postgresql_flexible_server) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_administrator_login"></a> [administrator\_login](#input\_administrator\_login) | The administrator login for the Postgres Flexible Server.<br/>Required when `create_mode` is Default and `authentication.password_auth_enabled` is true | `string` | `null` | no |
| <a name="input_administrator_password"></a> [administrator\_password](#input\_administrator\_password) | The administrator password for the Postgres Flexible Server.<br/>Required when `create_mode` is Default and `authentication.password_auth_enabled` is true | `string` | `null` | no |
| <a name="input_authentication"></a> [authentication](#input\_authentication) | active\_directory\_auth\_enabled = Whether or not Active Directory authentication is enabled for this server<br/>password\_auth\_enabled         = Whether or not password authentication is enabled for this server<br/>tenant\_id                     = The tenant ID of the Active Directory to use for authentication | <pre>object({<br/>    active_directory_auth_enabled = optional(bool)<br/>    password_auth_enabled         = optional(bool)<br/>    tenant_id                     = optional(string)<br/>  })</pre> | `null` | no |
| <a name="input_auto_grow_enabled"></a> [auto\_grow\_enabled](#input\_auto\_grow\_enabled) | Storage auto grow for PostgreSQL Flexible Server. | `bool` | `false` | no |
| <a name="input_backup_retention_days"></a> [backup\_retention\_days](#input\_backup\_retention\_days) | The backup retention days for the Postgres Flexible Server, between 7 and 35 days | `number` | `7` | no |
| <a name="input_create_mode"></a> [create\_mode](#input\_create\_mode) | The creation mode. Possible values are Default, GeoRestore, PointInTimeRestore, Replica, and Update | `string` | `"Default"` | no |
| <a name="input_delegated_subnet_id"></a> [delegated\_subnet\_id](#input\_delegated\_subnet\_id) | The ID of the subnet to which the Postgres Flexible Server is delegated | `string` | `null` | no |
| <a name="input_geo_redundant_backup_enabled"></a> [geo\_redundant\_backup\_enabled](#input\_geo\_redundant\_backup\_enabled) | Whether or not geo-redundant backups are enabled for this server | `bool` | `false` | no |
| <a name="input_high_availability"></a> [high\_availability](#input\_high\_availability) | mode                      = The high availability mode. Possible values are SameZone or ZoneRedundant<br/>standby\_availability\_zone = The availability zone for the standby server | <pre>object({<br/>    mode                      = string<br/>    standby_availability_zone = optional(string)<br/>  })</pre> | `null` | no |
| <a name="input_identity_ids"></a> [identity\_ids](#input\_identity\_ids) | Specifies a list of User Assigned Managed Identity IDs to be assigned | `list(string)` | `null` | no |
| <a name="input_location"></a> [location](#input\_location) | Location of the Postgres Flexible Server | `string` | n/a | yes |
| <a name="input_maintenance_window"></a> [maintenance\_window](#input\_maintenance\_window) | The maintenance window of the Postgres Flexible Server<br/>day\_of\_week = The day of the week when maintenance should be performed<br/>start\_hour   = The start hour of the maintenance window<br/>start\_minute = The start minute of the maintenance window | <pre>object({<br/>    day_of_week  = optional(string, 0)<br/>    start_hour   = optional(number, 0)<br/>    start_minute = optional(number, 0)<br/>  })</pre> | <pre>{<br/>  "day_of_week": 0,<br/>  "start_hour": 0,<br/>  "start_minute": 0<br/>}</pre> | no |
| <a name="input_name"></a> [name](#input\_name) | Resource name of the Postgres Flexible Server | `string` | n/a | yes |
| <a name="input_postgres_version"></a> [postgres\_version](#input\_postgres\_version) | Version of the Postgres Flexible Server. Required when `create_mode` is Default | `string` | `"16"` | no |
| <a name="input_private_dns_zone_id"></a> [private\_dns\_zone\_id](#input\_private\_dns\_zone\_id) | The ID of the private DNS zone. Required when `delegated_subnet_id` is set | `string` | `null` | no |
| <a name="input_public_network_access_enabled"></a> [public\_network\_access\_enabled](#input\_public\_network\_access\_enabled) | Whether or not public network access is allowed for this server | `bool` | `false` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | Resource group name of the Postgres Flexible Server | `string` | n/a | yes |
| <a name="input_sku_name"></a> [sku\_name](#input\_sku\_name) | The name of the SKU used by this Postgres Flexible Server | `string` | `"B_Standard_B1ms"` | no |
| <a name="input_source_server_id"></a> [source\_server\_id](#input\_source\_server\_id) | The ID of the source Postgres Flexible Server to restore from. Required when `create_mode` is GeoRestore, PointInTimeRestore, or Replica | `string` | `null` | no |
| <a name="input_storage_mb"></a> [storage\_mb](#input\_storage\_mb) | The storage capacity of the Postgres Flexible Server in megabytes | `number` | `null` | no |
| <a name="input_storage_tier"></a> [storage\_tier](#input\_storage\_tier) | The storage tier of the Postgres Flexible Server. Default value based on `storage_mb` | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A mapping of tags to assign to the resource | `map(string)` | `{}` | no |
| <a name="input_zone"></a> [zone](#input\_zone) | The zone of the Postgres Flexible Server | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_delegated_subnet_id"></a> [delegated\_subnet\_id](#output\_delegated\_subnet\_id) | n/a |
| <a name="output_fqdn"></a> [fqdn](#output\_fqdn) | n/a |
| <a name="output_id"></a> [id](#output\_id) | n/a |
| <a name="output_name"></a> [name](#output\_name) | n/a |
| <a name="output_private_dns_zone_id"></a> [private\_dns\_zone\_id](#output\_private\_dns\_zone\_id) | n/a |
| <a name="output_source_server_id"></a> [source\_server\_id](#output\_source\_server\_id) | n/a |
<!-- END_TF_DOCS -->
