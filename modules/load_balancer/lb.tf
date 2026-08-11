resource "azurerm_lb" "loadBalancer" {
  for_each            = var.lb
  name                = each.value.name
  resource_group_name = data.azurerm_resource_group.rg[each.key].name
  location            = data.azurerm_resource_group.rg[each.key].location
  sku                 = lookup(each.value, "sku", null)
  edge_zone           = lookup(each.value, "edge_zone", null)
  sku_tier            = lookup(each.value, "sku_tier", null)
  tags                = lookup(each.value, "tags", {})
  dynamic "frontend_ip_configuration" {
    for_each = each.value.frontend_ip_configuration
    content {
      name                                               = frontend_ip_configuration.value.name
      zones                                              = lookup(frontend_ip_configuration.value, "zones", null)
      subnet_id                                          = frontend_ip_configuration.value.subnet_id != null ? data.azurerm_subnet.subnet[each.key].id : null
      gateway_load_balancer_frontend_ip_configuration_id = lookup(frontend_ip_configuration.value, "gateway_load_balancer_frontend_ip_configuration_id", null)
      private_ip_address                                 = lookup(frontend_ip_configuration.value, "private_ip_address", null)
      private_ip_address_allocation                      = lookup(frontend_ip_configuration.value, "private_ip_address_allocation", null)
      private_ip_address_version                         = lookup(frontend_ip_configuration.value, "private_ip_address_version", null)
      public_ip_address_id                               = frontend_ip_configuration.value.public_ip_address_id != null ? data.azurerm_public_ip.pip[each.key].id : null
      public_ip_prefix_id                                = lookup(frontend_ip_configuration.value, "public_ip_prefix_id", null)
    }
  }
}
