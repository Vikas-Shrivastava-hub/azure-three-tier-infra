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
    virtual_id        = optional(string)
    session_recording_enabled = optional(bool)
    tags                      = optional(map(string))
    zones                     = optional(list(string))
  }))
}
