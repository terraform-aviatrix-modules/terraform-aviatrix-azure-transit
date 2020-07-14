variable "region" {
    description = "The Azure region to deploy this module in"
    type = string
}

variable "cidr" {
    description = "The CIDR range to be used for the VNET"
    type = string
}

variable "azure_account_name" {
    description = "The Azure account name, as known by the Aviatrix controller"
    type = string
}

variable "instance_size" {
    description = "Azure Instance size for the Aviatrix gateways"
    type = string
    default = "Standard_B1s"
}

variable "ha_gw" {
    description = "Boolean to determine if module will be deployed in HA or single mode"
    type = bool
    default = true
}
