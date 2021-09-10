resource "cloudfoundry_service_instance" "superset_redis" {
  space        = data.cloudfoundry_space.space.id
  name         = "tf-superset-redis-${random_id.id.hex}"
  service_plan = data.cloudfoundry_service.redis.service_plans[var.redis_plan]
}

resource "cloudfoundry_service_key" "superset_redis_key" {
  name             = "key"
  service_instance = cloudfoundry_service_instance.superset_redis.id
}

module "redis-service" {
  source  = "philips-labs/redis-service/hsdp"
  version = "0.2.0"

  cf_space_id  = data.cloudfoundry_space.space.id
  name_postfix = local.postfix
}
