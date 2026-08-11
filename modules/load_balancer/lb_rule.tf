resource "azurerm_lb_rule" "lb_rule" {
  for_each                       = var.lb
  name                           = each.value.rule_name
  loadbalancer_id                = azurerm_lb.loadBalancer[each.key].id
  frontend_ip_configuration_name = each.value.frontend_ip_configuration_name
  protocol                       = each.value.rule_protocol
  frontend_port                  = each.value.frontend_port
  backend_port                   = each.value.backend_port
  backend_address_pool_ids       = [azurerm_lb_backend_address_pool.backend_pool[each.key].id]
}
