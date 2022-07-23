# HSDP Apache Superset module

This module deploys Apache Superset on Container Host. It also deploys a Caddy based reverse proxy on Cloud foundry so you can access
the Apache Superset UI.

<!--- BEGIN_TF_DOCS --->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_hsdp"></a> [hsdp](#requirement\_hsdp) | >= 0.26.3 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_cloudfoundry"></a> [cloudfoundry](#provider\_cloudfoundry) | 0.14.2 |
| <a name="provider_hsdp"></a> [hsdp](#provider\_hsdp) | 0.26.3 |
| <a name="provider_random"></a> [random](#provider\_random) | 3.1.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_postgres"></a> [postgres](#module\_postgres) | philips-labs/postgres-service/hsdp | n/a |
| <a name="module_redis"></a> [redis](#module\_redis) | philips-labs/redis-service/hsdp | 0.2.0 |

## Resources

| Name | Type |
|------|------|
| [cloudfoundry_app.superset_proxy](https://registry.terraform.io/providers/cloudfoundry-community/cloudfoundry/latest/docs/resources/app) | resource |
| [cloudfoundry_route.superset_proxy](https://registry.terraform.io/providers/cloudfoundry-community/cloudfoundry/latest/docs/resources/route) | resource |
| [hsdp_container_host.superset](https://registry.terraform.io/providers/philips-software/hsdp/latest/docs/resources/container_host) | resource |
| [hsdp_container_host_exec.server](https://registry.terraform.io/providers/philips-software/hsdp/latest/docs/resources/container_host_exec) | resource |
| [hsdp_container_host_exec.worker](https://registry.terraform.io/providers/philips-software/hsdp/latest/docs/resources/container_host_exec) | resource |
| [random_id.id](https://registry.terraform.io/providers/random/latest/docs/resources/id) | resource |
| [cloudfoundry_domain.domain](https://registry.terraform.io/providers/cloudfoundry-community/cloudfoundry/latest/docs/data-sources/domain) | data source |
| [cloudfoundry_org.org](https://registry.terraform.io/providers/cloudfoundry-community/cloudfoundry/latest/docs/data-sources/org) | data source |
| [cloudfoundry_service.db](https://registry.terraform.io/providers/cloudfoundry-community/cloudfoundry/latest/docs/data-sources/service) | data source |
| [cloudfoundry_service.redis](https://registry.terraform.io/providers/cloudfoundry-community/cloudfoundry/latest/docs/data-sources/service) | data source |
| [cloudfoundry_space.space](https://registry.terraform.io/providers/cloudfoundry-community/cloudfoundry/latest/docs/data-sources/space) | data source |
| [hsdp_config.cf](https://registry.terraform.io/providers/philips-software/hsdp/latest/docs/data-sources/config) | data source |
| [hsdp_config.logging](https://registry.terraform.io/providers/philips-software/hsdp/latest/docs/data-sources/config) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_agent"></a> [agent](#input\_agent) | Use SSH agent for authentication | `bool` | `false` | no |
| <a name="input_caddy_image"></a> [caddy\_image](#input\_caddy\_image) | Caddy server image to use | `string` | `"caddy:2.4.5"` | no |
| <a name="input_cartel_secret"></a> [cartel\_secret](#input\_cartel\_secret) | The Cartel secret to use for autoscaling | `string` | `""` | no |
| <a name="input_cartel_token"></a> [cartel\_token](#input\_cartel\_token) | The Cartel token to use for autoscaling | `string` | `""` | no |
| <a name="input_docker_password"></a> [docker\_password](#input\_docker\_password) | Docker registry password | `string` | `""` | no |
| <a name="input_docker_username"></a> [docker\_username](#input\_docker\_username) | Docker registry username | `string` | `""` | no |
| <a name="input_fluent_bit_image"></a> [fluent\_bit\_image](#input\_fluent\_bit\_image) | Fluent-bit image | `string` | `"philipssoftware/fluent-bit-out-hsdp:latest"` | no |
| <a name="input_hsdp_custom_field"></a> [hsdp\_custom\_field](#input\_hsdp\_custom\_field) | Post structured JSON message to HSDP Logging custom field | `string` | `"true"` | no |
| <a name="input_hsdp_environment"></a> [hsdp\_environment](#input\_hsdp\_environment) | The HSDP environment of the deployment | `string` | `"client-test"` | no |
| <a name="input_hsdp_product_key"></a> [hsdp\_product\_key](#input\_hsdp\_product\_key) | HSDP Logging product key | `string` | `""` | no |
| <a name="input_hsdp_region"></a> [hsdp\_region](#input\_hsdp\_region) | The HSDP region of the deployment | `string` | `"us-east"` | no |
| <a name="input_hsdp_secret_key"></a> [hsdp\_secret\_key](#input\_hsdp\_secret\_key) | HSDP Logging secret key | `string` | `""` | no |
| <a name="input_hsdp_shared_key"></a> [hsdp\_shared\_key](#input\_hsdp\_shared\_key) | HSDP Logging shared key | `string` | `""` | no |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | The instance type to use | `string` | `"t2.medium"` | no |
| <a name="input_name_postfix"></a> [name\_postfix](#input\_name\_postfix) | The postfix string to append to the hostname, prevents namespace clashes | `string` | `""` | no |
| <a name="input_org_name"></a> [org\_name](#input\_org\_name) | Cloudfoundry ORG name to use for reverse proxy | `string` | n/a | yes |
| <a name="input_postgres_plan"></a> [postgres\_plan](#input\_postgres\_plan) | The HSDP-RDS PostgreSQL plan to use | `string` | `"postgres-medium-dev"` | no |
| <a name="input_private_key"></a> [private\_key](#input\_private\_key) | Private key for SSH access (should not have a passphrase) | `string` | `""` | no |
| <a name="input_redis_plan"></a> [redis\_plan](#input\_redis\_plan) | The Redis plan to use | `string` | `"redis-standalone"` | no |
| <a name="input_space_name"></a> [space\_name](#input\_space\_name) | Cloudfoundry SPACE name to use for reverse proxy | `string` | n/a | yes |
| <a name="input_superset_image"></a> [superset\_image](#input\_superset\_image) | The Temporal server image to use | `string` | `"apache/superset:latest-dev"` | no |
| <a name="input_user"></a> [user](#input\_user) | LDAP user to use for connections | `string` | n/a | yes |
| <a name="input_user_groups"></a> [user\_groups](#input\_user\_groups) | User groups to assign to cluster | `list(string)` | n/a | yes |
| <a name="input_volume_size"></a> [volume\_size](#input\_volume\_size) | The volume size to use in GB | `number` | `50` | no |
| <a name="input_worker_instance_type"></a> [worker\_instance\_type](#input\_worker\_instance\_type) | Instance type of worker nodes | `string` | `"m5.xlarge"` | no |
| <a name="input_workers"></a> [workers](#input\_workers) | Number of worker nodes to spin up | `number` | `1` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_superset_id"></a> [superset\_id](#output\_superset\_id) | Server ID of Superset |
| <a name="output_superset_ip"></a> [superset\_ip](#output\_superset\_ip) | Private IP address of Superset server |
| <a name="output_superset_proxy_endpoint"></a> [superset\_proxy\_endpoint](#output\_superset\_proxy\_endpoint) | URL of the Superset proxy |

<!--- END_TF_DOCS --->

# Contact / Getting help

Please post your questions on the HSDP Slack `#terraform` channel

# License

License is MIT

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_hsdp"></a> [hsdp](#requirement\_hsdp) | >= 0.26.3 |
| <a name="requirement_ssh"></a> [ssh](#requirement\_ssh) | >= 2.1.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_cloudfoundry"></a> [cloudfoundry](#provider\_cloudfoundry) | 0.14.2 |
| <a name="provider_hsdp"></a> [hsdp](#provider\_hsdp) | 0.26.3 |
| <a name="provider_random"></a> [random](#provider\_random) | 3.1.0 |
| <a name="provider_ssh"></a> [ssh](#provider\_ssh) | 2.1.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_postgres"></a> [postgres](#module\_postgres) | philips-labs/postgres-service/hsdp | n/a |
| <a name="module_redis"></a> [redis](#module\_redis) | philips-labs/redis-service/hsdp | 0.2.0 |

## Resources

| Name | Type |
|------|------|
| [cloudfoundry_app.superset_proxy](https://registry.terraform.io/providers/cloudfoundry-community/cloudfoundry/latest/docs/resources/app) | resource |
| [cloudfoundry_route.superset_proxy](https://registry.terraform.io/providers/cloudfoundry-community/cloudfoundry/latest/docs/resources/route) | resource |
| [hsdp_container_host.superset](https://registry.terraform.io/providers/philips-software/hsdp/latest/docs/resources/container_host) | resource |
| [random_id.id](https://registry.terraform.io/providers/random/latest/docs/resources/id) | resource |
| [ssh_resource.server](https://registry.terraform.io/providers/loafoe/ssh/latest/docs/resources/resource) | resource |
| [ssh_resource.server_volumes](https://registry.terraform.io/providers/loafoe/ssh/latest/docs/resources/resource) | resource |
| [ssh_resource.worker](https://registry.terraform.io/providers/loafoe/ssh/latest/docs/resources/resource) | resource |
| [cloudfoundry_domain.domain](https://registry.terraform.io/providers/cloudfoundry-community/cloudfoundry/latest/docs/data-sources/domain) | data source |
| [cloudfoundry_org.org](https://registry.terraform.io/providers/cloudfoundry-community/cloudfoundry/latest/docs/data-sources/org) | data source |
| [cloudfoundry_service.db](https://registry.terraform.io/providers/cloudfoundry-community/cloudfoundry/latest/docs/data-sources/service) | data source |
| [cloudfoundry_service.redis](https://registry.terraform.io/providers/cloudfoundry-community/cloudfoundry/latest/docs/data-sources/service) | data source |
| [cloudfoundry_space.space](https://registry.terraform.io/providers/cloudfoundry-community/cloudfoundry/latest/docs/data-sources/space) | data source |
| [hsdp_config.cf](https://registry.terraform.io/providers/philips-software/hsdp/latest/docs/data-sources/config) | data source |
| [hsdp_config.logging](https://registry.terraform.io/providers/philips-software/hsdp/latest/docs/data-sources/config) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_agent"></a> [agent](#input\_agent) | Use SSH agent for authentication | `bool` | `false` | no |
| <a name="input_caddy_image"></a> [caddy\_image](#input\_caddy\_image) | Caddy server image to use | `string` | `"caddy:2.4.5"` | no |
| <a name="input_cartel_secret"></a> [cartel\_secret](#input\_cartel\_secret) | The Cartel secret to use for autoscaling | `string` | `""` | no |
| <a name="input_cartel_token"></a> [cartel\_token](#input\_cartel\_token) | The Cartel token to use for autoscaling | `string` | `""` | no |
| <a name="input_docker_password"></a> [docker\_password](#input\_docker\_password) | Docker registry password | `string` | `""` | no |
| <a name="input_docker_username"></a> [docker\_username](#input\_docker\_username) | Docker registry username | `string` | `""` | no |
| <a name="input_fluent_bit_image"></a> [fluent\_bit\_image](#input\_fluent\_bit\_image) | Fluent-bit image | `string` | `"philipssoftware/fluent-bit-out-hsdp:latest"` | no |
| <a name="input_hsdp_custom_field"></a> [hsdp\_custom\_field](#input\_hsdp\_custom\_field) | Post structured JSON message to HSDP Logging custom field | `string` | `"true"` | no |
| <a name="input_hsdp_environment"></a> [hsdp\_environment](#input\_hsdp\_environment) | The HSDP environment of the deployment | `string` | `"client-test"` | no |
| <a name="input_hsdp_product_key"></a> [hsdp\_product\_key](#input\_hsdp\_product\_key) | HSDP Logging product key | `string` | `""` | no |
| <a name="input_hsdp_region"></a> [hsdp\_region](#input\_hsdp\_region) | The HSDP region of the deployment | `string` | `"us-east"` | no |
| <a name="input_hsdp_secret_key"></a> [hsdp\_secret\_key](#input\_hsdp\_secret\_key) | HSDP Logging secret key | `string` | `""` | no |
| <a name="input_hsdp_shared_key"></a> [hsdp\_shared\_key](#input\_hsdp\_shared\_key) | HSDP Logging shared key | `string` | `""` | no |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | The instance type to use | `string` | `"t2.medium"` | no |
| <a name="input_name_postfix"></a> [name\_postfix](#input\_name\_postfix) | The postfix string to append to the hostname, prevents namespace clashes | `string` | `""` | no |
| <a name="input_org_name"></a> [org\_name](#input\_org\_name) | Cloudfoundry ORG name to use for reverse proxy | `string` | n/a | yes |
| <a name="input_postgres_plan"></a> [postgres\_plan](#input\_postgres\_plan) | The HSDP-RDS PostgreSQL plan to use | `string` | `"postgres-medium-dev"` | no |
| <a name="input_private_key"></a> [private\_key](#input\_private\_key) | Private key for SSH access (should not have a passphrase) | `string` | `""` | no |
| <a name="input_redis_plan"></a> [redis\_plan](#input\_redis\_plan) | The Redis plan to use | `string` | `"redis-standalone"` | no |
| <a name="input_space_name"></a> [space\_name](#input\_space\_name) | Cloudfoundry SPACE name to use for reverse proxy | `string` | n/a | yes |
| <a name="input_superset_image"></a> [superset\_image](#input\_superset\_image) | The Temporal server image to use | `string` | `"apache/superset:latest-dev"` | no |
| <a name="input_user"></a> [user](#input\_user) | LDAP user to use for connections | `string` | n/a | yes |
| <a name="input_user_groups"></a> [user\_groups](#input\_user\_groups) | User groups to assign to cluster | `list(string)` | n/a | yes |
| <a name="input_volume_size"></a> [volume\_size](#input\_volume\_size) | The volume size to use in GB | `number` | `50` | no |
| <a name="input_worker_instance_type"></a> [worker\_instance\_type](#input\_worker\_instance\_type) | Instance type of worker nodes | `string` | `"m5.xlarge"` | no |
| <a name="input_workers"></a> [workers](#input\_workers) | Number of worker nodes to spin up | `number` | `1` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_superset_id"></a> [superset\_id](#output\_superset\_id) | Server ID of Superset |
| <a name="output_superset_ip"></a> [superset\_ip](#output\_superset\_ip) | Private IP address of Superset server |
| <a name="output_superset_proxy_endpoint"></a> [superset\_proxy\_endpoint](#output\_superset\_proxy\_endpoint) | URL of the Superset proxy |
<!-- END_TF_DOCS -->