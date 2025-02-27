variable "base-name" {
  type = string
  description = "resource group variable"
  default = "rg-group2018"
}
variable "location" {
  type = string
  description = "resourcegroup location"
  default = "eastus"
}
variable "vnet" {
  type = string
  description = "vnet name"
  default = "eastus"
}
variable "tags" {
  type = map(string)
  description = "tag values of resource-group"
  default = {
    "env" = "test" 
    "Owner" = "Travis"
  }
}
variable "address_space" {
    type = list(any)
    description = "addressspace of the Vnet"
    default = [ "10.13.0.0/16"]
  
}
variable "subnets" {
   type = map(any)
   default = {
     "subnet1" = {
        name = "Subnet01"
        address_prefixes =["10.13.1.0/24"]
     }
     "subnet1" = {
        name = "Subnet02"
        address_prefixes =["10.13.2.0/24"]
     }
     "subnet1" = {
        name = "Subnet03"
        address_prefixes =["10.13.3.0/24"]
     }
     "bastion_subnet" = {
        name = "AzureBastionSubnet"
        address_prefixes =["10.13.250.0/24"]
     }
   }
  
}
variable "bastionhost_name" {
  type = string
  default = "AzureBastionSubnet"
  description = "bastionHostName"
}