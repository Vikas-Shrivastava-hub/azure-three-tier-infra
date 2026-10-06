data "azurerm_resource_group" "rg" {
  for_each = var.identity
  name     = each.value.rg_name
}
