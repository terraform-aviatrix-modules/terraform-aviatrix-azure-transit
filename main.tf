#Transit VPC
resource "aviatrix_vpc" "default" {
  cloud_type           = 8
  name                 = "vnet-transit-${var.region_normalized}"
  region               = var.region
  cidr                 = var.cidr
  account_name         = var.azure_account_name
}

# Single Transit GW
resource "aviatrix_transit_gateway" "single" {
  count = var.ha_gw ? 0 : 1
  enable_active_mesh = true
  cloud_type         = 1
  vpc_reg            = var.region
  gw_name            = "tg-${var.region_normalized}"
  gw_size            = var.instance_size
  vpc_id             = aviatrix_vpc.default.vpc_id
  account_name       = var.azure_account_name
  subnet             = cidrsubnet(var.cidr, 4, 0)
  connected_transit  = true
  tag_list = [
    "Auto-StartStop-Enabled:",
  ]
}

# HA Transit GW
resource "aviatrix_transit_gateway" "ha" {
  count = var.ha_gw ? 1 : 0
  enable_active_mesh = true
  cloud_type         = 1
  vpc_reg            = var.region
  gw_name            = "tg-${var.region_normalized}"
  gw_size            = var.instance_size
  vpc_id             = aviatrix_vpc.default.vpc_id
  account_name       = var.azure_account_name
  subnet             = cidrsubnet(var.cidr, 4, 0)
  ha_subnet          = cidrsubnet(var.cidr, 4, 1)
  ha_gw_size         = var.instance_size
  connected_transit  = true
  tag_list = [
    "Auto-StartStop-Enabled:",
  ]
}

