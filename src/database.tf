resource "cloudfoundry_service_instance" "superset_db" {
  space        = data.cloudfoundry_space.space.id
  name         = "tf-superset-db-${random_id.id.hex}"
  service_plan = data.cloudfoundry_service.db.service_plans[var.postgres_plan]
}

resource "cloudfoundry_service_key" "superset_db_key" {
  name             = "key"
  service_instance = cloudfoundry_service_instance.superset_db.id
}
