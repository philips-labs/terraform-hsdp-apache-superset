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
      postgres_username = module.postgres.credentials.username
      postgres_password = module.postgres.credentials.password
      postgres_hostname = module.postgres.credentials.hostname
      redis_host        = module.redis.credentials.hostname
      redis_password    = module.redis.credentials.password
      enable_fluentd    = var.hsdp_product_key == "" ? "false" : "true"
      log_driver        = var.hsdp_product_key == "" ? "local" : "fluentd"
      superset_image    = var.superset_image
      superset_id       = random_id.id.hex
    })
    destination = "/home/${var.user}/bootstrap-server.sh"
    permissions = "0755"
  }

  file {
    content = templatefile("${path.module}/templates/superset_config.py", {
      postgres_uri = module.postgres.credentials.uri
    })
    destination = "/home/${var.user}/superset_config.py"
    permissions = "0644"
  }

  commands = [
    "/home/${var.user}/bootstrap-fluent-bit.sh",
    "/home/${var.user}/bootstrap-server.sh",
    "docker exec superset bash -c 'pip install werkzeug==0.16.0'",
    "docker exec superset bash -c 'pip install sqlalchemy-redshift'",
    "docker exec superset bash -c 'pip install sqlalchemy-vertica-python'",
    "docker exec superset bash -c 'flask fab create-permissions'",
    "docker exec superset bash -c 'flask fab create-db'",
    "docker cp /home/${var.user}/superset_config.py superset:/app/pythonpath",
    "docker exec superset bash -c 'superset init'",
    "docker exec superset bash -c 'superset db upgrade'",
    "docker restart superset",
  ]
}

resource "hsdp_container_host_exec" "worker" {
  triggers = {
    cluster_instance_ids = hsdp_container_host.superset.id
  }

  depends_on = [hsdp_container_host_exec.server]

  host        = hsdp_container_host.superset.private_ip
  user        = var.user
  private_key = var.private_key

  file {
    content = templatefile("${path.module}/scripts/bootstrap-worker.sh.tmpl", {
      postgres_username = module.postgres.credentials.username
      postgres_password = module.postgres.credentials.password
      postgres_hostname = module.postgres.credentials.hostname
      redis_host        = module.redis.credentials.hostname
      redis_password    = module.redis.credentials.password
      enable_fluentd    = var.hsdp_product_key == "" ? "false" : "true"
      log_driver        = var.hsdp_product_key == "" ? "local" : "fluentd"
      superset_image    = var.superset_image
      superset_id       = random_id.id.hex
    })
    destination = "/home/${var.user}/bootstrap-worker.sh"
    permissions = "0755"
  }

  file {
    content = templatefile("${path.module}/templates/superset_config.py", {
      postgres_uri = module.postgres.credentials.uri
    })
    destination = "/home/${var.user}/superset_config.py"
    permissions = "0644"
  }

  # Bootstrap script called with private_ip of each node in the cluster
  commands = [
    "/home/${var.user}/bootstrap-worker.sh",
    "docker exec superset-worker bash -c 'pip install werkzeug==0.16.0'",
    "docker exec superset-worker bash -c 'pip install sqlalchemy-redshift'",
    "docker exec superset-worker bash -c 'pip install sqlalchemy-vertica-python'",
    "docker cp /home/${var.user}/superset_config.py superset-worker:/app/pythonpath",
    "docker restart superset-worker",
  ]
}
