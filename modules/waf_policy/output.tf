output "waf_policy_id" {
  value = { for k, waf in azurerm_web_application_firewall_policy.waf : k => waf.id }

}