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

locals {
  lower_name        = length(var.name) > 0 ? replace(lower(var.name), " ", "-") : replace(lower(var.region), " ", "-")
  prefix            = var.prefix ? "avx-" : ""
  suffix            = var.suffix ? "-transit" : ""
  name              = "${local.prefix}${local.lower_name}${local.suffix}"
  subnet            = var.insane_mode ? cidrsubnet(var.cidr, 3, 6) : aviatrix_vpc.default.subnets[0].cidr
  ha_subnet         = var.insane_mode ? cidrsubnet(var.cidr, 3, 7) : aviatrix_vpc.default.subnets[0].cidr
}