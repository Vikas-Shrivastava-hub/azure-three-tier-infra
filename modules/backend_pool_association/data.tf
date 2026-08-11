data "azurerm_network_interface" "nic" {
    for_each = var.pool_association
    name = each.value.nic_name
    resource_group_name = each.value.rg_name
}
data "azurerm_lb" "lb" {
    for_each = var.pool_association
    name = each.value.lb_name
    resource_group_name = each.value.rg_name
}
data "azurerm_lb_backend_address_pool" "backend" {
    for_each = var.pool_association
    name = each.value.backend_name
    loadbalancer_id = data.azurerm_lb.lb[each.key].id
}