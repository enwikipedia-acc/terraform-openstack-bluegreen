terraform {
  required_version = ">= 1.3.0"
}

locals {
  prod_env    = var.live_environment == "blue" ? var.blue_dns_name : var.green_dns_name
  staging_env = var.staging_environment == null ? null : (var.staging_environment == "blue" ? var.blue_dns_name : var.green_dns_name)
  blue_count  = var.live_environment == "blue" || var.staging_environment == "blue" ? 1 : 0
  green_count = var.live_environment == "green" || var.staging_environment == "green" ? 1 : 0
}
