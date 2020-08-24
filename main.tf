#Transit VPC
resource "aviatrix_vpc" "default" {
  cloud_type   = 8
  name         = length(var.name) > 0 ? "avx-${var.name}-transit" : replace(lower("avx-${var.region}-transit"), " ", "-")
  region       = var.region
  cidr         = var.cidr
  account_name = var.account
}

# Single Transit GW
resource "aviatrix_transit_gateway" "single" {
  count              = var.ha_gw ? 0 : 1
  enable_active_mesh = true
  cloud_type         = 8
  vpc_reg            = var.region
  gw_name            = length(var.name) > 0 ? "avx-${var.name}-transit" : replace(lower("avx-${var.region}-transit"), " ", "-")
  gw_size            = var.instance_size
  vpc_id             = aviatrix_vpc.default.vpc_id
  account_name       = var.account
  subnet             = aviatrix_vpc.default.subnets[0].cidr
  connected_transit  = var.connected_transit
}

# HA Transit GW
resource "aviatrix_transit_gateway" "ha" {
  count              = var.ha_gw ? 1 : 0
  enable_active_mesh = true
  cloud_type         = 8
  vpc_reg            = var.region
  gw_name            = length(var.name) > 0 ? "avx-${var.name}-transit" : replace(lower("avx-${var.region}-transit"), " ", "-")
  gw_size            = var.instance_size
  vpc_id             = aviatrix_vpc.default.vpc_id
  account_name       = var.account
  subnet             = aviatrix_vpc.default.subnets[0].cidr
  ha_subnet          = aviatrix_vpc.default.subnets[2].cidr
  ha_gw_size         = var.instance_size
  connected_transit  = var.connected_transit
}

