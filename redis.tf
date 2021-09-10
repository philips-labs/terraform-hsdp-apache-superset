module "redis" {
  source  = "philips-labs/redis-service/hsdp"
  version = "0.2.0"

  cf_space_id  = data.cloudfoundry_space.space.id
  name_postfix = local.postfix
}
