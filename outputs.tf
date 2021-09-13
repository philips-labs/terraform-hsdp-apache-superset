output "superset_proxy_endpoint" {
  description = "URL of the Superset proxy"
  value       = cloudfoundry_route.superset_proxy.endpoint
}

output "superset_ip" {
  description = "Private IP address of Superset server"
  value       = hsdp_container_host.superset.private_ip
}

output "superset_id" {
  description = "Server ID of Superset"
  value       = random_id.id.hex
}
