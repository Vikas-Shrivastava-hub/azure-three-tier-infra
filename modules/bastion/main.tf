resource "azurerm_bastion_host" "bastion" {
  for_each            = var.bastion
  name                = each.value.name
  resource_group_name = data.azurerm_resource_group.rg[each.key].name
  location            = data.azurerm_resource_group.rg[each.key].location
  copy_paste_enabled  = lookup(each.value, "copy_paste_enabled", null)
  file_copy_enabled   = lookup(each.value, "file_copy_enabled", null)
  sku                 = lookup(each.value, "sku", null)
  ip_configuration {
    name                 = each.value.ip_configuration.name
    subnet_id            = data.azurerm_subnet.subnet[each.key].id
    public_ip_address_id = data.azurerm_public_ip.pip[each.key].id
  }
  ip_connect_enabled        = lookup(each.value, "ip_connect_enabled", null)
  kerberos_enabled          = lookup(each.value, "kerberos_enabled", null)
  scale_units               = lookup(each.value, "scale_units", null)
  shareable_link_enabled    = lookup(each.value, "shareable_link_enabled", null)
  tunneling_enabled         = lookup(each.value, "tunneling_enabled", null)
  session_recording_enabled = lookup(each.value, "session_recording_enabled", null)
  virtual_network_id        = lookup(each.value, "virtual_id", null)
  tags                      = lookup(each.value, "tags", {})
  zones                     = lookup(each.value, "zones", null)
}
