
data "azurerm_public_ip" "pip" {
  for_each            = var.nat_gateway_associate
  name                = each.value.public_ip_name
  resource_group_name = each.value.rg_name
}
