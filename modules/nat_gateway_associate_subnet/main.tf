resource "azurerm_subnet_nat_gateway_association" "subnet_association" {
  for_each = var.nat_gateway_association

  subnet_id      = data.azurerm_subnet.subnet[each.key].id
  nat_gateway_id = var.nat_gateway_id
}
