# Module Aviatrix Transit VNET for Azure

### Description
This module deploys a VNET and a set of Aviatrix transit gateways.

### Compatibility
Module version | Terraform version | Controller version | Terraform provider version
:--- | :--- | :--- | :---
v1.1.0 | 0.12 | 6.1 | 2.16, 2.16.1, 2.16.2
v1.0.2 | 0.12 | 6.1 | 2.16, 2.16.1
v1.0.2 | 0.12 | 6.0 | 2.15, 2.15.1
v1.0.1 | 0.12 | |
v1.0.0 | 0.12 | |

### Diagram
<img src="https://github.com/terraform-aviatrix-modules/terraform-aviatrix-azure-transit/blob/master/img/module-aviatrix-transit-vpc-for-azure-ha.png?raw=true">

with ha_gw set to false, the following will be deployed:

<img src="https://github.com/terraform-aviatrix-modules/terraform-aviatrix-azure-transit/blob/master/img/module-aviatrix-transit-vpc-for-azure.png?raw=true">

### Usage Example
```
module "transit_azure_1" {
  source  = "terraform-aviatrix-modules/azure-transit/aviatrix"
  version = "v1.1.0"
  
  cidr = "10.1.0.0/20"
  region = "West Europe"
  account = "Azure"
}
```

### Variables
The following variables are required:

key | value
:--- | :---
region | Azure region to deploy the transit VNET in
account | The Azure account name on the Aviatrix controller, under which the controller will deploy this VNET
cidr | The IP CIDR wo be used to create the VNET.

The following variables are optional:

key | default | value
:---|:---|:---
instance_size | Standard_B1ms | 	Size of the transit gateway instances. **Insane mode requires a minimum Standard_D3_v2 instance size**
ha_gw | true | Set to false to deploy a single transit GW
name | null | When this string is set, user defined name is applied to all infrastructure supporting n+1 sets within a same region or other customization
insane_mode | false | Set to true to enable Aviatrix insane mode high-performance encryption
connected_transit | true | Allows spokes to run traffic to other spokes via transit gateway
active_mesh | true | Set to false to disable Active Mesh mode for the transit gateway

### Outputs
Outputs
This module will return the following objects:

key | description
:--- | :---
vnet | The created vnet as an object with all of it's attributes. This was created using the aviatrix_vpc resource.
transit_gateway | The created Aviatrix transit gateway as an object with all of it's attributes.
azure_vnet_name | The Azure vnet name created
azure_rg_name | The Azure resource group name created
