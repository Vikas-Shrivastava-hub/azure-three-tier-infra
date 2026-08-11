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
