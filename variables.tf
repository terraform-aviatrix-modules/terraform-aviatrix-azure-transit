variable "region" {
    type = string
    default = "eu-west-1"
}

variable "cidr" {
    type = string
}

variable "azure_account_name" {
    type = string
}

variable "instance_size" {
    type = string
    default = "Standard_B1s"
}

variable "ha_gw" {
    type = bool
    default = false
}