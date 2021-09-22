data "hsdp_config" "cf" {
  service = "cf"
}

data "hsdp_config" "logging" {
  service = "logging"
}

data "cloudfoundry_org" "org" {
  name = var.org_name
}

data "cloudfoundry_space" "space" {
  name = var.space_name
  org  = data.cloudfoundry_org.org.id
}

data "cloudfoundry_domain" "domain" {
  name = data.hsdp_config.cf.domain
}

data "cloudfoundry_service" "db" {
  name = "hsdp-rds"
}

data "cloudfoundry_service" "redis" {
  name = "hsdp-redis-db"
}
