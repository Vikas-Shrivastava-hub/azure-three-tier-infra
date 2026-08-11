variable "rg" {
  type = map(object({
    name       = string
    location   = string
    managed_by = optional(string)
    tags       = optional(map(string))
  }))
}
variable "vnet" {
  type = map(object({
    name          = string
    location      = optional(string)
    rg_name       = string
    address_space = list(string)
  }))
}
variable "subnet" {
  type = map(object({
    name             = string
    vnet_name        = string
    rg_name          = string
    address_prefixes = list(string)
    delegation = optional(object({
      name         = string
      service_name = string
      action       = optional(list(string))
    }))
    default_outbound_access_enabled = optional(bool)
    ip_address_pool = optional(object({
      id                     = string
      number_of_ip_addresses = number
    }))
    private_endpoint_network_policies             = optional(string)
    private_link_service_network_policies_enabled = optional(bool)
    sharing_scope                                 = optional(string)
    service_endpoints                             = optional(list(string))
    service_endpoint_policy_ids                   = optional(list(string))

  }))
}
variable "pip" {
  type = map(object({
    name                    = string
    rg_name                 = string
    allocation_method       = string
    zones                   = optional(list(string))
    ddos_protection_mode    = optional(string)
    ddos_protection_plan_id = optional(string)
    domain_name_label       = optional(string)
    domain_name_label_scope = optional(string)
    edge_zone               = optional(string)
    idle_timeout_in_minutes = optional(number)
    ip_version              = optional(string)
    public_ip_prefix_id     = optional(string)
    reverse_fqdn            = optional(string)
    sku                     = optional(string)
    sku_tier                = optional(string)
    tags                    = optional(map(string))
    ip_tags                 = optional(map(string))
  }))
}
variable "nsg" {
  type = map(object({
    name    = string
    rg_name = string
    security_rule = optional(map(object({
      name                         = string
      priority                     = number
      direction                    = string
      access                       = string
      protocol                     = string
      source_address_prefix        = string
      destination_address_prefix   = string
      source_port_range            = string
      destination_port_range       = string
      source_port_ranges           = optional(list(string))
      destination_port_ranges      = optional(list(string))
      destination_address_prefixes = optional(list(string))
      source_address_prefixes      = optional(list(string))


    })))
  }))
}
variable "nic" {
  type = map(object({
    name        = string
    rg_name     = string
    subnet_name = string
    vnet_name   = string
    ip_configuration = map(object({
      name                                               = string
      private_ip_address_allocation                      = string
      gateway_load_balancer_frontend_ip_configuration_id = optional(string)
      private_ip_address_version                         = optional(string)
      public_ip_address_id                               = optional(string)
    }))
    auxiliary_mode                 = optional(string)
    auxiliary_sku                  = optional(string)
    dns_server                     = optional(list(string))
    edge_zone                      = optional(string)
    ip_forwarding_enabled          = optional(bool)
    accelerated_networking_enabled = optional(bool)
    internal_dns_name_label        = optional(string)
  }))
}
variable "vm" {
  type = map(object({
    name           = string
    rg_name        = string
    kv_rg_name     = string
    key_vault_name = string
    secret_name    = string
    nic_name       = string
    vm_size        = string
    storage_image_reference = object({
      publisher = string
      offer     = string
      sku       = string
      version   = string
    })
    storage_os_disk = object({
      name              = string
      caching           = string
      create_option     = string
      managed_disk_type = string
    })
    os_profile = object({
      computer_name  = string
      admin_username = string
    })
    os_profile_linux_config = object({
      disabled_password_authentication = bool
    })
  }))
}

variable "bastion" {
  type = map(object({
    name                         = string
    rg_name                      = string
    subnet_name                  = string
    vnet_name                    = string
    pip_name                     = string
    copy_paste_enabled           = optional(bool)
    disable_tunneling_protection = optional(bool)
    ip_configuration = optional(object({
      name = string
    }))
    file_copy_enabled         = optional(bool)
    ip_connect_enabled        = optional(bool)
    kerberos_enabled          = optional(bool)
    scale_units               = optional(number)
    shareable_link_enabled    = optional(bool)
    tunneling_enabled         = optional(bool)
    sku                       = optional(string)
    virtual_id                = optional(string)
    session_recording_enabled = optional(bool)
    tags                      = optional(map(string))
    zones                     = optional(list(string))
  }))
}
variable "lb" {
  type = map(object({
    name        = string
    rg_name     = string
    subnet_name = string
    vnet_name   = string
    pip_name    = string
    sku         = optional(string)
    edge_zone   = optional(string)
    sku_tier    = optional(string)
    tags        = optional(map(string))
    frontend_ip_configuration = map(object({
      name                                               = string
      zones                                              = optional(list(string))
      subnet_id                                          = optional(string)
      gateway_load_balancer_frontend_ip_configuration_id = optional(string)
      private_ip_address                                 = optional(string)
      private_ip_address_allocation                      = optional(string)
      private_ip_address_version                         = optional(string)
      public_ip_address_id                               = optional(string)
      public_ip_prefix_id                                = optional(string)
    }))
    pool_name          = string
    loadbalancer_id    = optional(string)
    synchronous_mode   = optional(string)
    virtual_network_id = optional(string)
    tunnel_interface = optional(object({
      identifier = string
      type       = string
      protocol   = string
      port       = number
    }))
    rule_name                      = string
    frontend_ip_configuration_name = string
    rule_protocol                  = string
    frontend_port                  = number
    backend_port                   = number

    probe_name          = string
    port                = number
    probe_protocol      = optional(string)
    probe_threshold     = optional(string)
    request_path        = optional(string)
    interval_in_seconds = optional(number)
    number_of_probes    = optional(number)

  }))
}

variable "pool_association" {
  type = map(object({
    ip_configuration_name = string
    nic_name              = string
    rg_name               = string
    lb_name               = string
    backend_name          = string
  }))
}
variable "associate" {
  type = map(object({
    nsg_name    = string
    rg_name     = string
    subnet_name = string
    vnet_name   = string
  }))
}
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
variable "agw_pool_association" {
  type = map(object({
    ip_configuration_name   = string
    nic_name = string
    rg_name  = string
    agw_name = string
    backend_name = string
  }))
}


