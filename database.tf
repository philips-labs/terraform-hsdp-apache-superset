module "postgres" {
  source = "philips-labs/postgres-service/hsdp"

  cf_space_id  = data.cloudfoundry_space.space.id
  name_postfix = local.postfix
}
