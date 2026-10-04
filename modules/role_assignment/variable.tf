variable "role_assignment" {
    type = map(object({
      rg_name              = string
      kv_name              = string
      role_definition_name = string
    }))
  
}
variable "principal_id" {
  type = string
}