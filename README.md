# Blue/Green deployments

This module provides a wrapper around blue/green deployments

It is intended for use with DNS-based switching and submodules wrapping each environment. This module performs all the "which is which?" calculations for you.

For example:

```tf
variable "live" {
  default = "blue"
}

variable "staging" {
  default = "green"
}

locals {
  blue_dns = "blue.example.internal."
  green_dns = "green.example.internal."
}

module "app-blue" {
    source = "../module/app"
    count = module.bluegreen.blue_count
    dns_name = local.blue_dns
}

module "app-green" {
    source = "../module/app"
    count = module.bluegreen.green_count
    dns_name = local.green_dns
}

module "bluegreen" {
  source  = "app.terraform.io/enwikipedia-acc/bluegreen/openstack"
  version = "0.1.0"
 
  blue_dns_name = local.blue_dns
  green_dns_name = local.green_dns

  live_environment = var.live
  staging_environment = var.staging
}

resource "openstack_dns_recordset_v2" "production" {
  zone_id     = "${openstack_dns_zone_v2.example_zone.id}"
  name        = "production.example.internal."
  type        = "CNAME"
  records     = [module.bluegreen.live_dns_name]
}

resource "openstack_dns_recordset_v2" "staging" {
  count       = module.bluegreen.staging_count
  zone_id     = "${openstack_dns_zone_v2.example_zone.id}"
  name        = "staging.example.internal."
  type        = "CNAME"
  records     = [module.bluegreen.staging_dns_name]
}
```