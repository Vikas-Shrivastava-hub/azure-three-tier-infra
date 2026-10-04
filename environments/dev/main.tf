module "rg" {
  source = "../../modules/resource_group"
  rg     = var.rg
}
module "vnet" {
  depends_on = [module.rg]
  source     = "../../modules/virtual_network"
  vnet       = var.vnet
}
module "subnet" {
  depends_on = [module.vnet]
  source     = "../../modules/subnet"
  subnet     = var.subnet
}
module "pip" {
  depends_on = [module.rg]
  source     = "../../modules/public_ip"
  pip        = var.pip
}
module "nsg" {
  depends_on = [module.rg]
  source     = "../../modules/nsg"
  nsg        = var.nsg
}
module "nic" {
  depends_on = [module.subnet, module.nsg]
  source     = "../../modules/nic"
  nic        = var.nic
}
module "vm" {
  depends_on = [module.nic]
  source     = "../../modules/virtual_machine"
  vm         = var.vm
}
module "bastion" {
  depends_on = [module.subnet, module.pip]
  source     = "../../modules/bastion"
  bastion    = var.bastion
}
module "lb" {
  depends_on = [module.subnet]
  source     = "../../modules/load_balancer"
  lb         = var.lb
}
module "backend_pool_association" {
  depends_on       = [module.nic, module.lb]
  source           = "../../modules/backend_pool_association"
  pool_association = var.pool_association
}
module "nsg_association" {
  depends_on = [module.nsg, module.subnet]
  source     = "../../modules/nsg_association"
  associate  = var.associate
}
module "agw" {
  depends_on         = [module.subnet, module.pip]
  source             = "../../modules/application_gateway"
  agw                = var.agw
  identity_ids       = module.identity.identity_id["identity1"]
  firewall_policy_id = module.waf_policy.waf_policy_id["waf1"]
}

module "application_pool_association" {
  depends_on           = [module.nic, module.agw]
  source               = "../../modules/application_pool_association"
  agw_pool_association = var.agw_pool_association
}
module "identity" {
  depends_on = [module.rg]
  source     = "../../modules/managed_identity"
  identity   = var.identity
}
module "role_assignment" {
  depends_on      = [module.identity, module.agw]
  source          = "../../modules/role_assignment"
  role_assignment = var.role_assignment
  principal_id    = module.identity.identity_id["identity1"]
}
module "waf_policy" {
  depends_on = [module.rg]
  source     = "../../modules/waf_policy"
  waf_policy = var.waf_policy
}
