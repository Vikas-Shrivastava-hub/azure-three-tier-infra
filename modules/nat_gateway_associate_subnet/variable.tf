variable "nat_gateway_association" {
  type = map(object({
    rg_name     = string
    subnet_name = string
    vnet_name   = string
  }))
}
variable "nat_gateway_id" {
  type = string
}
