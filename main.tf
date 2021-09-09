locals {
  postfix = var.name_postfix != "" ? var.name_postfix : random_id.id.hex
}

resource "random_id" "id" {
  byte_length = 8
}

resource "hsdp_container_host" "superset" {
  name          = "superset-${local.postfix}.dev"
  volumes       = 1
  volume_size   = var.volume_size
  instance_type = var.instance_type

  user_groups     = var.user_groups
  security_groups = ["analytics"]

  user        = var.user
  private_key = var.private_key

  commands = [
    "docker volume create superset",
    "docker volume create superset-frontend",
    "docker volume create superset-home",
    "docker volume create tests"
  ]
}

resource "hsdp_container_host_exec" "server" {
  triggers = {
    cluster_instance_ids = hsdp_container_host.superset.id
  }

  host        = hsdp_container_host.superset.private_ip
  user        = var.user
  private_key = var.private_key

  file {
    content = templatefile("${path.module}/scripts/bootstrap-server.sh.tmpl", {
      postgres_username = cloudfoundry_service_key.superset_db_key.credentials.username
      postgres_password = cloudfoundry_service_key.superset_db_key.credentials.password
      postgres_hostname = cloudfoundry_service_key.superset_db_key.credentials.hostname
      redis_host        = cloudfoundry_service_key.superset_redis_key.credentials.host
      redis_password    = cloudfoundry_service_key.superset_redis_key.credentials.password
      enable_fluentd    = var.hsdp_product_key == "" ? "false" : "true"
      log_driver        = var.hsdp_product_key == "" ? "local" : "fluentd"
      superset_image    = var.superset_image
      superset_id       = random_id.id.hex
    })
    destination = "/home/${var.user}/bootstrap-server.sh"
    permissions = "0755"
  }

  file {
    content = templatefile("${path.module}/scripts/bootstrap-fluent-bit.sh.tmpl", {
      ingestor_host    = data.hsdp_config.logging.url
      shared_key       = var.hsdp_shared_key
      secret_key       = var.hsdp_secret_key
      product_key      = var.hsdp_product_key
      custom_field     = var.hsdp_custom_field
      fluent_bit_image = var.fluent_bit_image
    })
    destination = "/home/${var.user}/bootstrap-fluent-bit.sh"
    permissions = "0755"
  }

  # Bootstrap script called with private_ip of each node in the cluster
  commands = [
    "/home/${var.user}/bootstrap-fluent-bit.sh",
    "/home/${var.user}/bootstrap-server.sh",
    "docker exec superset bash -c 'pip install werkzeug==0.16.0'",
    "docker exec superset bash -c 'pip install sqlalchemy-redshift'",
    "docker exec superset bash -c 'pip install sqlalchemy-vertica-python'",
    "docker exec superset bash -c 'flask fab create-permissions'",
    "docker exec superset bash -c 'flask fab create-db'",
    "docker exec superset bash -c 'superset init'"
  ]
}
