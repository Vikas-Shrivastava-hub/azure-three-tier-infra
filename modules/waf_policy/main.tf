resource "azurerm_web_application_firewall_policy" "waf" {
  for_each = var.waf_policy

  name                = each.value.name
  resource_group_name = data.azurerm_resource_group.rg[each.key].name
  location            = data.azurerm_resource_group.rg[each.key].location

  policy_settings {
    enabled = each.value.policy_settings.enabled
    mode    = each.value.policy_settings.mode
  }

  managed_rules {
    managed_rule_set {
      type    = each.value.managed_rule_set.type
      version = each.value.managed_rule_set.version
    }
  }
}