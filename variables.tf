variable "region" {
  description = "The Azure region to deploy this module in"
  type        = string
}

variable "cidr" {
  description = "The CIDR range to be used for the VNET"
  type        = string
}

variable "account" {
  description = "The Azure account name, as known by the Aviatrix controller"
  type        = string
  default     = ""
}

variable "name" {
  description = "Custom name for VNETs, gateways, and firewalls"
  type        = string
  default     = ""
}

variable "prefix" {
  description = "Boolean to determine if name will be prepended with avx-"
  type        = bool
  default     = true
}

variable "suffix" {
  description = "Boolean to determine if name will be appended with -spoke"
  type        = bool
  default     = true
}

variable "instance_size" {
  description = "Azure Instance size for the Aviatrix gateways"
  type        = string
  default     = "Standard_B1ms"
}

variable "ha_gw" {
  description = "Boolean to determine if module will be deployed in HA or single mode"
  type        = bool
  default     = true
}

variable "connected_transit" {
  description = "Enables Aviatrix connected transit"
  type        = bool
  default     = true
}

variable "active_mesh" {
  description = "Enables Aviatrix active mesh"
  type        = bool
  default     = true
}

variable "bgp_manual_spoke_advertise_cidrs" {
  description = "Define a list of CIDRs that should be advertised via BGP."
  type        = string
  default     = ""
}

variable "learned_cidr_approval" {
  description = "Set to true to enable learned CIDR approval."
  type        = string
  default     = "false"
}

variable "insane_mode" {
  description = "Set to true to enable Aviatrix high performance encryption."
  type        = bool
  default     = false
}

variable "enable_segmentation" {
  description = "Switch to true to enable transit segmentation"
  type        = bool
  default     = false
}

variable "single_az_ha" {
  description = "Set to true if Controller managed Gateway HA is desired"
  type        = bool
  default     = true
}

variable "single_ip_snat" {
  description = "Enable single_ip mode Source NAT for this container"
  type        = bool
  default     = false
}

variable "enable_advertise_transit_cidr" {
  description = "Switch to enable/disable advertise transit VPC network CIDR for a VGW connection"
  type        = bool
  default     = false
}

variable "enable_firenet" {
  description = "Sign of readiness for FireNet connection"
  type        = bool
  default     = false
}

variable "enable_transit_firenet" {
  description = "Sign of readiness for Transit FireNet connection"
  type        = bool
  default     = false
}

variable "enable_egress_transit_firenet" {
  description = "Enable Egress Transit FireNet"
  type        = bool
  default     = false
}
variable "bgp_polling_time" {
  description = "BGP route polling time. Unit is in seconds"
  type        = string
  default     = "50"
}

variable "bgp_ecmp" {
  description = "Enable Equal Cost Multi Path (ECMP) routing for the next hop"
  type        = bool
  default     = false
}

variable "local_as_number" {
  description = "The gateways local AS number"
  type        = string
  default     = null
}

variable "enable_bgp_over_lan" {
  description = "Enable BGp over LAN. Creates eth4 for integration with SDWAN for example"
  type        = bool
  default     = false
}

variable "az_support" {
  description = "Set to true if the Azure region supports AZ's"
  type        = bool
  default     = true
}

variable "az1" {
  description = "AZ Zone to be used for GW deployment."
  type        = string
  default     = "az-1"
}

variable "az2" {
  description = "AZ Zone to be used for HAGW deployment."
  type        = string
  default     = "az-2"
}

variable "resource_group" {
  description = "Provide the name of an existing resource group."
  type        = string
  default     = null
}

 

locals {
  lower_name = length(var.name) > 0 ? replace(lower(var.name), " ", "-") : replace(lower(var.region), " ", "-")
  prefix     = var.prefix ? "avx-" : ""
  suffix     = var.suffix ? "-transit" : ""
  name       = "${local.prefix}${local.lower_name}${local.suffix}"
  cidrbits   = tonumber(split("/", var.cidr)[1])
  newbits    = 26 - local.cidrbits
  netnum     = pow(2, local.newbits)
  subnet     = var.insane_mode ? cidrsubnet(var.cidr, local.newbits, local.netnum - 2) : aviatrix_vpc.default.public_subnets[0].cidr
  ha_subnet  = var.insane_mode ? cidrsubnet(var.cidr, local.newbits, local.netnum - 1) : aviatrix_vpc.default.public_subnets[0].cidr
}
