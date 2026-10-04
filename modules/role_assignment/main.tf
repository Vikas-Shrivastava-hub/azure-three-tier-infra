resource "azurerm_role_assignment" "role" {
    for_each = var.role_assignment
  scope                = data.azurerm_key_vault.kv[each.key].id
  role_definition_name = each.value.role_definition_name
  principal_id         = var.principal_id
}