variable "cf_username" {}
variable "cf_password" {}
variable "private_key_file" {}


variable "ldap_user" {
  type = string
}

variable "cartel_token" {
  type = string
}

variable "cartel_secret" {
  type = string
}

variable "cartel_skip_verify" {
  type    = bool
  default = true
}

variable "cf_org_name" {
  type = string
}

variable "cf_space_name" {
  type = string
}

variable "hsdp_region" {
  type    = string
  default = "us-east"
}

variable "hsdp_environment" {
  type    = string
  default = "client-test"
}

variable "hsdp_product_key" {
  type        = string
  default     = ""
  description = "HSDP Logging produyct key"
  sensitive   = true
}

variable "hsdp_shared_key" {
  type        = string
  default     = ""
  description = "HSDP Logging shared key"
  sensitive   = true
}

variable "hsdp_secret_key" {
  type        = string
  default     = ""
  description = "HSDP Logging secret key"
  sensitive   = true
}

variable "hsdp_custom_field" {
  type        = string
  default     = "true"
  description = "Writes structured log messages to the custom HSDP logging field"
}

variable "workers" {
  type        = number
  default     = 1
  description = "Number of Temporal workers to spawn"
}

variable "docker_username" {
  type        = string
  description = "Docker registry username"
  default     = ""
}

variable "docker_password" {
  type        = string
  description = "Docker registry password"
  default     = ""
}
