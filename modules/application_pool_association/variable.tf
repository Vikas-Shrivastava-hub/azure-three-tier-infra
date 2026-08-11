variable "agw_pool_association" {
  type = map(object({
    ip_configuration_name   = string
    nic_name = string
    rg_name  = string
    agw_name = string
    backend_name = string
  }))
}