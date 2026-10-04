variable "identity" {
  type = map(object({
    name    = string
    rg_name = string
  }))
}
