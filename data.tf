data "cloudfoundry_org" "org" {
  name = var.org_name
}

data "cloudfoundry_space" "space" {
  name = var.space_name
}

data "cloudfoundry_domain" "domain" {
  name = var.app_domain
}

data "cloudfoundry_service" "db" {
  name = "hsdp-rds"
}

data "cloudfoundry_service" "redis" {
  name = "hsdp-redis-server"
}
