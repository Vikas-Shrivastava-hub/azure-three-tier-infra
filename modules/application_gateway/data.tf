data "azurerm_resource_group" "rg" {
  for_each = var.agw
  name     = each.value.rg_name
}
data "azurerm_subnet" "subnet" {
  for_each             = var.agw
  name                 = each.value.subnet_name
  virtual_network_name = each.value.vnet_name
  resource_group_name  = each.value.rg_name
}
data "azurerm_public_ip" "pip" {
  for_each            = var.agw
  name                = each.value.public_ip_address
  resource_group_name = each.value.rg_name
}
data "azurerm_key_vault_secret" "kv_secret" {
  for_each     = var.agw
  name         = each.value.ssl_certificate_name
  key_vault_id = data.azurerm_key_vault.kv[each.key].id
}
data "azurerm_key_vault" "kv" {
  for_each            = var.agw
  name                = each.value.kv_name
  resource_group_name = each.value.kv_rg_name
}
