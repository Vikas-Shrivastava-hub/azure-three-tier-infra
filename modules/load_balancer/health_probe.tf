resource "azurerm_lb_probe" "lb_probe" {
  for_each            = var.lb
  name                = each.value.probe_name
  loadbalancer_id     = azurerm_lb.loadBalancer[each.key].id
  port                = each.value.port
  protocol            = lookup(each.value, "probe_protocol", null)
  probe_threshold     = lookup(each.value, "probe_threshold", null)
  request_path        = lookup(each.value, "request_path", null)
  interval_in_seconds = lookup(each.value, "interval_in_seconds", null)
  number_of_probes    = lookup(each.value, "number_of_probes", null)

}
