resource "azurerm_nat_gateway_public_ip_association" "pip_association" {
  for_each = var.nat_gateway_associate

  nat_gateway_id       = var.nat_gateway_id
  public_ip_address_id = data.azurerm_public_ip.pip[each.key].id
}
