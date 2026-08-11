resource "azurerm_network_interface_backend_address_pool_association" "backedn_association" {
    for_each = var.pool_association
    network_interface_id    = data.azurerm_network_interface.nic[each.key].id
    ip_configuration_name   = each.value.ip_configuration_name
    backend_address_pool_id = data.azurerm_lb_backend_address_pool.backend[each.key].id
}