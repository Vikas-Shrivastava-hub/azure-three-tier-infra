resource "azurerm_virtual_network" "vnet" {
  for_each            = var.vnet
  name                = each.value.name
  location            = data.azurerm_resource_group.rg[each.key].location
  resource_group_name = data.azurerm_resource_group.rg[each.key].name
  address_space       = each.value.address_space
}
