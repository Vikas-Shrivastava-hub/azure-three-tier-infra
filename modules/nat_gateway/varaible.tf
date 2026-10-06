variable "nat_gateway" {
  type = map(object({
    name                    = string
    rg_name                 = string
    sku_name                = optional(string)
    idle_timeout_in_minutes = optional(number)
    zones                   = optional(list(string))
  }))
}
