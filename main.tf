terraform { 
  required_version = ">= 1.1.0"
  required_providers {
    azurerm = {
        source  = "hashicorp/azurerm"
       version = "~> 3.0.2"
    }
  }
}

provider "azurerm" {
  features {
    
  }
}
 
resource "azurerm_resource_group" "rg-grp" {
  name     = var.base-name
  location = var.location
  tags= var.tags
}

resource "azurerm_virtual_network" "vnet" {
  name = var.vnet
  address_space = var.address_space
  resource_group_name = azurerm_resource_group.rg-grp.name
  location = azurerm_resource_group.rg-grp.location
}

resource "azurerm_subnet" "subnet" {
  for_each = var.subnets  
  resource_group_name = azurerm_resource_group.rg-grp.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  name= each.value["name"]
  address_prefixes = each.value["address_prefixes"]
}

resource "azurerm_public_ip" "bastion-pubip" {
  name = "${var.bastionhost_name}PubIP"
  location = azurerm_resource_group.rg-grp.location
  resource_group_name = azurerm_resource_group.rg-grp.name
  tags = var.tags
  sku = "Standard"
  allocation_method = "Static"
}

resource "azurerm_bastion_host" "bastion" {
  name = var.bastionhost_name
  location = azurerm_resource_group.rg-grp.location
  resource_group_name = azurerm_resource_group.rg-grp.name
  tags = var.tags
  sku = "Standard"
  
  ip_configuration {
    name = "bastion-config"
    subnet_id = azurerm_subnet.subnet["bastion_subnet"].id
    public_ip_address_id = azurerm_public_ip.bastion-pubip.id
  }


}