output "vpc" {
  description = "The created VPC with all of it's attributes"
  value       = aviatrix_vpc.default
}

output "transit_gateway" {
  description = "The Aviatrix transit gateway object with all of it's attributes"
  value       = var.ha_gw ? aviatrix_transit_gateway.ha[0] : aviatrix_transit_gateway.single[0]
}