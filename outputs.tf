output "azurerm_subnet_id" {
  value = {
    for id in keys(var.subnets) : id => azurerm_subnet.subnet[id].id
   }
  description = "list of ids of subnets"
}
output "bastion-pub-ip" {
  value= azurerm_public_ip.bastion-pubip.ip_address
  description = "bastion public ip"
}
