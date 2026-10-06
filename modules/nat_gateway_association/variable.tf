variable "nat_gateway_associate" {
  type = map(object({
    rg_name        = string
    public_ip_name = string
  }))
}
variable "nat_gateway_id" {
  type = string
}
