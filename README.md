# Module Aviatrix Transit VNET for Azure

### Description
This module deploys a VNET and a set of Aviatrix transit gateways.

### Compatibility
Module version | Terraform version | Controller version | Terraform provider version
:--- | :--- | :--- | :---
v4.0.0 | 0.13 + 0.14 | >=6.4 | >=0.2.19
v3.0.1 | 0.13 | >=6.3 | >=0.2.18
v3.0.0 | 0.13 | >=6.2 | >=0.2.17

**_Information on older releases can be found in respective release notes._*

### Diagram
<img src="https://github.com/terraform-aviatrix-modules/terraform-aviatrix-azure-transit/blob/master/img/module-aviatrix-transit-vpc-for-azure-ha.png?raw=true">

with ha_gw set to false, the following will be deployed:

<img src="https://github.com/terraform-aviatrix-modules/terraform-aviatrix-azure-transit/blob/master/img/module-aviatrix-transit-vpc-for-azure.png?raw=true">

### Usage Example
```
module "transit_azure_1" {
  source  = "terraform-aviatrix-modules/azure-transit/aviatrix"
  version = "4.0.0"
  
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
bgp_manual_spoke_advertise_cidrs | | Intended CIDR list to advertise via BGP. Example: "10.2.0.0/16,10.4.0.0/16" 
learned_cidr_approval | false | Switch to true to enable learned CIDR approval
active_mesh | true | Set to false to disable Active Mesh mode for the transit gateway
prefix | true | Boolean to enable prefix name with avx-
suffix | true | Boolean to enable suffix name with -transit
enable_segmentation | false | Switch to true to enable transit segmentation
single_az_ha | true | Set to false if Controller managed Gateway HA is desired
single_ip_snat | false | Enable single_ip mode Source NAT for this container
enable_advertise_transit_cidr  | false | Switch to enable/disable advertise transit VPC network CIDR for a VGW connection
enable_firenet  | false | Sign of readiness for FireNet connection
enable_transit_firenet  | false | Sign of readiness for Transit FireNet connection
enable_egress_transit_firenet  | false | Enable Egress Transit FireNet
bgp_polling_time  | 50 | BGP route polling time. Unit is in seconds
bgp_ecmp | false | Enable Equal Cost Multi Path (ECMP) routing for the next hop
local_as_number	| null |Changes the Aviatrix Transit Gateway ASN number before you setup Aviatrix Transit Gateway connection configurations.
enable_bgp_over_lan |	false |	Enable BGP over LAN. Creates eth4 for integration with SDWAN for example
az_support | true | Set to false if the Azure region does not support Availability Zones.
az1 | az-1 | AZ Zone to be used for Transit GW
az2 | az-2 | AZ Zone to be used for HA Transit GW
resource_group | null | Provide the name of an existing resource group.
tunnel_detection_time | null | The IPsec tunnel down detection time for the Spoke Gateway in seconds. Must be a number in the range [20-600]. Default is 60.
tags | null | Map of tags to assign to the gateway.
enable_multi_tier_transit |	false |	Switch to enable multi tier transit
local_as_number | | Transit GW AS Number. Mandatory when multi tier transit is enabled.


### Outputs
Outputs
This module will return the following objects:

key | description
:--- | :---
vnet | The created vnet as an object with all of it's attributes. This was created using the aviatrix_vpc resource.
transit_gateway | The created Aviatrix transit gateway as an object with all of it's attributes.
azure_vnet_name | The Azure vnet name created
azure_rg_name | The Azure resource group name created
