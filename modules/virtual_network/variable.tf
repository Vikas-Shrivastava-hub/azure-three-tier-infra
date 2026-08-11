variable "vnet" {
  type = map(object({
    name          = string
    location      = optional(string)
    rg_name       = string
    address_space = list(string)
  }))
}
