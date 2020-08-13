#Transit VPC
resource "aviatrix_vpc" "default" {
  cloud_type   = 8
  name         = replace(lower("vnet-transit-${var.region}"), " ", "-")
  region       = var.region
  cidr         = var.cidr
  account_name = var.azure_account_name
}

# Single Transit GW
resource "aviatrix_transit_gateway" "single" {
  count              = var.ha_gw ? 0 : 1
  enable_active_mesh = true
  cloud_type         = 8
  vpc_reg            = var.region
  gw_name            = replace(lower("tg-${var.region}"), " ", "-")
  gw_size            = var.instance_size
  vpc_id             = aviatrix_vpc.default.vpc_id
  account_name       = var.azure_account_name
  subnet             = aviatrix_vpc.default.subnets[0].cidr
  connected_transit  = true
}

# HA Transit GW
resource "aviatrix_transit_gateway" "ha" {
  count              = var.ha_gw ? 1 : 0
  enable_active_mesh = true
  cloud_type         = 8
  vpc_reg            = var.region
  gw_name            = replace(lower("tg-${var.region}"), " ", "-")
  gw_size            = var.instance_size
  vpc_id             = aviatrix_vpc.default.vpc_id
  account_name       = var.azure_account_name
  subnet             = aviatrix_vpc.default.subnets[0].cidr
  ha_subnet          = aviatrix_vpc.default.subnets[2].cidr
  ha_gw_size         = var.instance_size
  connected_transit  = true
}

