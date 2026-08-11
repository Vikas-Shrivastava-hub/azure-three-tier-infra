data "azurerm_network_interface" "nic" {
    for_each = var.agw_pool_association
    name = each.value.nic_name
    resource_group_name = each.value.rg_name
}
data "azurerm_application_gateway" "agw" {
    for_each = var.agw_pool_association
    name = each.value.agw_name
    resource_group_name = each.value.rg_name
}
