resource "azurerm_lb_backend_address_pool" "backend_pool" {
  for_each           = var.lb
  name               = each.value.pool_name
  loadbalancer_id    = azurerm_lb.loadBalancer[each.key].id
  synchronous_mode   = lookup(each.value, "synchronous_mode", null)
  virtual_network_id = lookup(each.value, "virtual_network_id", null)
  dynamic "tunnel_interface" {
    for_each = each.value.tunnel_interface != null ? [each.value.tunnel_interface] : []
    content {
      identifier = tunnel_interface.value.identifier
      type       = tunnel_interface.value.type
      protocol   = tunnel_interface.value.protocol
      port       = tunnel_interface.value.port
    }
  }
}
