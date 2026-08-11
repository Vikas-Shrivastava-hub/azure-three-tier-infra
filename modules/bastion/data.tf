data "azurerm_resource_group" "rg" {
    for_each = var.bastion
    name = each.value.rg_name
}
data "azurerm_subnet" "subnet" {
    for_each = var.bastion
    name = each.value.subnet_name
    virtual_network_name = each.value.vnet_name
    resource_group_name = each.value.rg_name
}
data "azurerm_public_ip" "pip" {
    for_each = var.bastion
    name = each.value.pip_name
    resource_group_name = each.value.rg_name
}
data "azurerm_virtual_network" "vnet" {
    for_each = var.bastion
    name = each.value.vnet_name
    resource_group_name = each.value.rg_name
}