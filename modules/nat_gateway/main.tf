resource "azurerm_nat_gateway" "nat_gateway" {
  for_each = var.nat_gateway

  name                    = each.value.name
  location                = data.azurerm_resource_group.rg[each.key].location
  resource_group_name     = data.azurerm_resource_group.rg[each.key].name
  sku_name                = each.value.sku_name
  idle_timeout_in_minutes = each.value.idle_timeout_in_minutes
  zones                   = each.value.zones
}
