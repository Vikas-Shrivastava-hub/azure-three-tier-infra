output "nat_gateway_id" {
  value = {
    for k, v in azurerm_nat_gateway.nat_gateway : k => v.id
  }
}
