resource "azurerm_application_gateway" "agw" {
  for_each = var.agw

  name                = each.value.name
  location            = data.azurerm_resource_group.rg[each.key].location
  resource_group_name = data.azurerm_resource_group.rg[each.key].name

  sku {
    name = each.value.sku.name
    tier = each.value.sku.tier
  }

  autoscale_configuration {
    min_capacity = each.value.autoscale_configuration.min_capacity
    max_capacity = each.value.autoscale_configuration.max_capacity
  }

  gateway_ip_configuration {
    name      = each.value.gateway_ip_configuration.name
    subnet_id = data.azurerm_subnet.subnet[each.key].id
  }

  dynamic "frontend_ip_configuration" {
    for_each = each.value.frontend_ip_configuration

    content {
      name                          = frontend_ip_configuration.value.name
      public_ip_address_id          = lookup(frontend_ip_configuration.value, "public_ip_address", null) != null ? data.azurerm_public_ip.pip[each.key].id : null
      private_ip_address            = lookup(frontend_ip_configuration.value, "private_ip_address", null)
      private_ip_address_allocation = lookup(frontend_ip_configuration.value, "private_ip_address_allocation", null)
      subnet_id                     = lookup(frontend_ip_configuration.value, "subnet_id", null)
    }
  }

  dynamic "frontend_port" {
    for_each = each.value.frontend_port

    content {
      name = frontend_port.value.name
      port = frontend_port.value.port
    }
  }

  dynamic "backend_address_pool" {
    for_each = each.value.backend_address_pool

    content {
      name         = backend_address_pool.value.name
      fqdns        = lookup(backend_address_pool.value, "fqdns", null)
      ip_addresses = lookup(backend_address_pool.value, "ip_addresses", null)  
    }
  }
  dynamic "probe" {
  for_each = each.value.probe

  content {
    name                                      = probe.value.name
    protocol                                  = probe.value.protocol
    path                                      = probe.value.path
    interval                                  = probe.value.interval
    timeout                                   = probe.value.timeout
    unhealthy_threshold                       = probe.value.unhealthy_threshold
    pick_host_name_from_backend_http_settings = lookup(probe.value, "pick_host_name_from_backend_http_settings", false)
    host                                      = lookup(probe.value, "host", null)

  }
}

  dynamic "backend_http_settings" {
    for_each = each.value.backend_http_settings

    content {
      name                  = backend_http_settings.value.name
      cookie_based_affinity = backend_http_settings.value.cookie_based_affinity
      port                  = backend_http_settings.value.port
      protocol              = backend_http_settings.value.protocol
      request_timeout       = backend_http_settings.value.request_timeout
      path                  = lookup(backend_http_settings.value, "path", null)
    }
  }

  dynamic "http_listener" {
    for_each = each.value.http_listener

    content {
      name                           = http_listener.value.name
      frontend_ip_configuration_name = http_listener.value.frontend_ip_configuration_name
      frontend_port_name             = http_listener.value.frontend_port_name
      protocol                       = http_listener.value.protocol
    }
  }

  dynamic "request_routing_rule" {
    for_each = each.value.request_routing_rule

    content {
      name                       = request_routing_rule.value.name
      priority                   = request_routing_rule.value.priority
      rule_type                  = request_routing_rule.value.rule_type
      http_listener_name         = request_routing_rule.value.http_listener_name
      backend_address_pool_name  = request_routing_rule.value.backend_address_pool_name
      backend_http_settings_name = request_routing_rule.value.backend_http_settings_name
    }
  }
}
