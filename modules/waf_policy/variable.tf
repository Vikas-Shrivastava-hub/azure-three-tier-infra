variable "waf_policy" {
  type = map(object({
    name    = string
    rg_name = string

    policy_settings = object({
      enabled = bool
      mode    = string
    })

    managed_rule_set = object({
      type    = string
      version = string
    })
  }))
}