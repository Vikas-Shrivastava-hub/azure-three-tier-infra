data "azurerm_key_vault" "kv" {
  for_each = var.role_assignment

  name                = each.value.kv_name
  resource_group_name = each.value.rg_name
}