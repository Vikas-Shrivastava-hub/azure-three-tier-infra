output "identity_id" {
  value = { for k, identity in azurerm_user_assigned_identity.identity : k => identity.id }
}
