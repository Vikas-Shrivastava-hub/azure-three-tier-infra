variable "nat_gateway_associate_public_ip" {
  type = map(object({
    rg_name        = string
    public_ip_name = string
  }))
}
variable "nat_gateway_id" {
  type = string
}
