data "azurerm_resource_group" "rg" {
  for_each = var.nat_gateway
  name     = each.value.rg_name

}
