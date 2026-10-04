resource "azurerm_user_assigned_identity" "identity" {
  for_each = var.identity

  name                = each.value.name
  location            = data.azurerm_resource_group.rg[each.key].location
  resource_group_name = data.azurerm_resource_group.rg[each.key].name
}
