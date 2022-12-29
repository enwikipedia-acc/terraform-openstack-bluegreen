output "live_dns_name" {
  value = local.prod_env
}

output "staging_dns_name" {
  value = local.staging_env
}

output "blue_count" {
  value = local.blue_count
}

output "green_count" {
  value = local.green_count
}

output "staging_count" {
  value = local.staging_env == null ? 0 : 1
}