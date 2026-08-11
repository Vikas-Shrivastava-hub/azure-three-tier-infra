resource "azurerm_network_interface_application_gateway_backend_address_pool_association" "pool_assocaite" {
    for_each = var.agw_pool_association
    network_interface_id    = data.azurerm_network_interface.nic[each.key].id
    ip_configuration_name   = each.value.ip_configuration_name
    backend_address_pool_id = data.azurerm_application_gateway.agw[each.key].backend_address_pool[0].id
}