data "azurerm_resource_group" "rg" {
    for_each = var.waf_policy
    name = each.value.rg_name
  
}