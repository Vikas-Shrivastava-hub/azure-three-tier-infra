variable "agw" {
  type = map(object({
    name              = string
    rg_name           = string
    subnet_name       = string
    vnet_name         = string
    public_ip_address = string



    sku = object({
      name = string
      tier = string
    })

    autoscale_configuration = object({
      min_capacity = number
      max_capacity = number
    })

    gateway_ip_configuration = object({
      name = string
    })

    frontend_ip_configuration = map(object({
      name                          = string
      public_ip_address             = optional(string)
      private_ip_address_allocation = optional(string)
      subnet_id                     = optional(string)
    }))

    frontend_port = map(object({
      name = string
      port = number
    }))

    backend_address_pool = map(object({
      name         = string
      fqdns        = optional(list(string))
      ip_addresses = optional(list(string))
    }))
    probe = map(object({
      name                                      = string
      protocol                                  = string
      path                                      = string
      interval                                  = number
      timeout                                   = number
      unhealthy_threshold                       = number
      pick_host_name_from_backend_http_settings = optional(bool)
      host                                      = optional(string)

    }))

    backend_http_settings = map(object({
      name                  = string
      cookie_based_affinity = string
      port                  = number
      protocol              = string
      request_timeout       = number
      path                  = optional(string)
    }))

    http_listener = map(object({
      name                           = string
      frontend_ip_configuration_name = string
      frontend_port_name             = string
      protocol                       = string
    }))

    request_routing_rule = map(object({
      name                       = string
      priority                   = number
      rule_type                  = string
      http_listener_name         = string
      backend_address_pool_name  = string
      backend_http_settings_name = string
    }))
  }))
}
