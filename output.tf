output "vpc" {
  description = "The created VPC with all of it's attributes"
  value       = aviatrix_vpc.default
}

output "transit_gateway" {
  description = "The Aviatrix transit gateway object with all of it's attributes"
  value       = var.ha_gw ? aviatrix_transit_gateway.ha[0] : aviatrix_transit_gateway.single[0]
}

output "azure_vnet_name" {
  description = "The Azure vnet name"
  value       = "${split(":", aviatrix_vpc.default.vpc_id)[0]}"
}

output "azure_rg" {
  description = "The Azure resource group name"
  value       = "${split(":", aviatrix_vpc.default.vpc_id)[1]}"
}