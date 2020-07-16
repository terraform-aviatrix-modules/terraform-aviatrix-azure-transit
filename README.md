# Module Aviatrix Transit VNET for Azure

### Description
This module deploys a VNET and a set of Aviatrix transit gateways.

### Diagram
<img src="https://dhagens-repository-images-public.s3.eu-central-1.amazonaws.com/terraform-aviatrix-azure-transit/module-aviatrix-transit-vpc-for-azure-ha.png"  height="250">

with ha_gw set to false, the following will be deployed:

<img src="https://dhagens-repository-images-public.s3.eu-central-1.amazonaws.com/terraform-aviatrix-azure-transit/module-aviatrix-transit-vpc-for-azure.png"  height="250">

### Usage Example
```
module "transit_azure_1" {
  source  = "terraform-aviatrix-modules/azure-transit/aviatrix"
  version = "v1.0.1"
  
  cidr = "10.1.0.0/20"
  region = "West Europe"
  azure_account_name = "Azure"
}
```

### Variables
The following variables are required:

key | value
:--- | :---
region | Azure region to deploy the transit VNET in
azure_account_name | The Azure accountname on the Aviatrix controller, under which the controller will deploy this VNET
cidr | The IP CIDR wo be used to create the VNET.

The following variables are optional:

key | default | value
:---|:---|:---
instance_size | Standard_B1s | Size of the transit gateway instances
ha_gw | true | Set to false to deploy a single transit GW

### Outputs
Outputs
This module will return the following objects:

key | description
:--- | :---
vnet | The created vnet as an object with all of it's attributes. This was created using the aviatrix_vpc resource.
transit_gateway | The created Aviatrix transit gateway as an object with all of it's attributes.
