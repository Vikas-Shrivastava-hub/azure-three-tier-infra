rg = {
  rg1 = {
    name     = "mono-dev-rg"
    location = "West US 3"
  }
}
vnet = {
  vnet1 = {
    name          = "mono-dev-vnet"
    rg_name       = "mono-dev-rg"
    address_space = ["10.0.0.0/16"]
  }
}
subnet = {
  subnet1 = {
    name             = "apw-mono-snet-dev"
    vnet_name        = "mono-dev-vnet"
    rg_name          = "mono-dev-rg"
    address_prefixes = ["10.0.1.0/24"]
  }
  subnet2 = {
    name             = "frontend-mono-snet-dev"
    vnet_name        = "mono-dev-vnet"
    rg_name          = "mono-dev-rg"
    address_prefixes = ["10.0.2.0/24"]
  }
  subnet3 = {
    name             = "backend-mono-snet-dev"
    vnet_name        = "mono-dev-vnet"
    rg_name          = "mono-dev-rg"
    address_prefixes = ["10.0.3.0/24"]
  }
  subnet4 = {
    name             = "AzureBastionSubnet"
    vnet_name        = "mono-dev-vnet"
    rg_name          = "mono-dev-rg"
    address_prefixes = ["10.0.4.0/24"]
  }
}
pip = {
  pip1 = {
    name              = "mono-dev-pip"
    rg_name           = "mono-dev-rg"
    allocation_method = "Static"
  }
  pip2 = {
    name              = "mono-dev-bastion-pip"
    rg_name           = "mono-dev-rg"
    allocation_method = "Static"
  }
}
nsg = {
  nsg1 = {
    name    = "mono-apw-dev-nsg"
    rg_name = "mono-dev-rg"
    security_rule = {
      rule1 = {
        name                       = "Allow-HTTP"
        priority                   = 100
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "80"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
      }

      rule2 = {
        name                       = "Allow-HTTPS"
        priority                   = 200
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "443"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
      }
      rule3 = {
        name                       = "Allow-GatewayManager"
        priority                   = 300
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "*"
        source_port_range          = "*"
        destination_port_range     = "65200-65535"
        source_address_prefix      = "GatewayManager"
        destination_address_prefix = "*"
      }
    }
  }

    nsg2 = {
      name    = "mono-frontend-dev-nsg"
      rg_name = "mono-dev-rg"
      security_rule = {
        rule1 = {
          name                       = "Allow-HTTP"
          priority                   = 100
          direction                  = "Inbound"
          access                     = "Allow"
          protocol                   = "Tcp"
          source_port_range          = "*"
          destination_port_range     = "80"
          source_address_prefix      = "10.0.1.0/24"
          destination_address_prefix = "*"
        }

        rule2 = {
          name                       = "Allow-HTTPS"
          priority                   = 200
          direction                  = "Inbound"
          access                     = "Allow"
          protocol                   = "Tcp"
          source_port_range          = "*"
          destination_port_range     = "443"
          source_address_prefix      = "10.0.1.0/24"
          destination_address_prefix = "*"
        }
        rule3 = {
          name                       = "allow-bastion"
          priority                   = 300
          direction                  = "Inbound"
          access                     = "Allow"
          protocol                   = "Tcp"
          source_port_range          = "*"
          destination_port_range     = "22"
          source_address_prefix      = "10.0.4.0/24"
          destination_address_prefix = "*"
        }
      }
    }
    nsg3 = {
      name    = "mono-backend-dev-nsg"
      rg_name = "mono-dev-rg"
      security_rule = {
        rule1 = {
          name                       = "Allow-HTTP"
          priority                   = 100
          direction                  = "Inbound"
          access                     = "Allow"
          protocol                   = "Tcp"
          source_port_range          = "*"
          destination_port_range     = "80"
          source_address_prefix      = "10.0.2.0/24"
          destination_address_prefix = "*"
        }
        rule2 = {

          name                       = "allow-lb-probe"
          priority                   = 110
          direction                  = "Inbound"
          access                     = "Allow"
          protocol                   = "*"
          source_port_range          = "*"
          destination_port_range     = "*"
          source_address_prefix      = "AzureLoadBalancer"
          destination_address_prefix = "*"
        }
        rule3 = {
          name                       = "allow-bastion"
          priority                   = 120
          direction                  = "Inbound"
          access                     = "Allow"
          protocol                   = "Tcp"
          source_port_range          = "*"
          destination_port_range     = "22"
          source_address_prefix      = "10.0.4.0/24"
          destination_address_prefix = "*"
        }
      }
    }
  }

nic = {
  nic1 = {
    name        = "mono-frontend-dev-nic"
    rg_name     = "mono-dev-rg"
    subnet_name = "frontend-mono-snet-dev"
    vnet_name   = "mono-dev-vnet"
    ip_configuration = {
      ipconfig1 = {
        name                          = "mono-frontend-dev-ipconfig"
        private_ip_address_allocation = "Dynamic"
      }
    }
  }
  nic2 = {
    name        = "mono-backend-dev-nic"
    rg_name     = "mono-dev-rg"
    subnet_name = "backend-mono-snet-dev"
    vnet_name   = "mono-dev-vnet"
    ip_configuration = {
      ipconfig1 = {
        name                          = "mono-backend-dev-ipconfig1"
        private_ip_address_allocation = "Dynamic"
      }
    }
  }

}
vm = {
  vm1 = {
    name           = "mono-frontend-dev-vm"
    rg_name        = "mono-dev-rg"
    nic_name       = "mono-frontend-dev-nic"
    vm_size        = "Standard_D2als_v7"
    kv_rg_name     = "mono-dev-shared-rg"
    key_vault_name = "mono-shared-kv"
    secret_name    = "mono-frontend-dev-vm-secret"
    storage_image_reference = {
      publisher = "Canonical"
      offer     = "ubuntu-24_04-lts"
      sku       = "server"
      version   = "latest"
    }
    storage_os_disk = {
      name              = "mono-frontend-dev-vm-os-disk"
      caching           = "ReadWrite"
      create_option     = "FromImage"
      managed_disk_type = "Standard_LRS"
    }
    os_profile = {
      computer_name  = "mono-frontend-dev-vm"
      admin_username = "forntendvm1"

    }
    os_profile_linux_config = {
      disabled_password_authentication = false
    }
  }
  vm2 = {
    name           = "mono-backend-dev-vm"
    rg_name        = "mono-dev-rg"
    nic_name       = "mono-backend-dev-nic"
    vm_size        = "Standard_D2als_v7"
    kv_rg_name     = "mono-dev-shared-rg"
    key_vault_name = "mono-shared-kv"
    secret_name    = "mono-backend-dev-vm-secret"
    storage_image_reference = {
      publisher = "Canonical"
      offer     = "ubuntu-24_04-lts"
      sku       = "server"
      version   = "latest"
    }
    storage_os_disk = {
      name              = "mono-backend-dev-vm-os-disk"
      caching           = "ReadWrite"
      create_option     = "FromImage"
      managed_disk_type = "Standard_LRS"
    }
    os_profile = {
      computer_name  = "mono-backend-dev-vm"
      admin_username = "backendvm1"

    }
    os_profile_linux_config = {
      disabled_password_authentication = false
    }
  }
}
bastion = {
  bastion1 = {
    name               = "Azurebastion-dev"
    rg_name            = "mono-dev-rg"
    subnet_name        = "AzureBastionSubnet"
    vnet_name          = "mono-dev-vnet"
    pip_name           = "mono-dev-bastion-pip"
    copy_paste_enabled = true
    tunneling_enabled  = true
    sku                = "Standard"
    ip_configuration = {
      name = "bastion_connect"
    }
  }
}
lb = {
  lb1 = {
    name        = "mono-dev-ilb"
    rg_name     = "mono-dev-rg"
    subnet_name = "backend-mono-snet-dev"
    vnet_name   = "mono-dev-vnet"
    pip_name    = "mono-dev-pip"
    sku         = "Standard"
    frontend_ip_configuration = {
      frontend1 = {
        name                          = "mono-dev-ilb-frontend"
        private_ip_address_allocation = "Static"
        private_ip_address            = "10.0.3.10"
        subnet_id                     = "abc"
      }

    }
    pool_name                      = "mono-dev-ilb-pool"
    rule_name                      = "mono-dev-ilb-rule"
    frontend_ip_configuration_name = "mono-dev-ilb-frontend"
    rule_protocol                  = "Tcp"
    frontend_port                  = 80
    backend_port                   = 80
    probe_name                     = "mono-dev-ilb-probe"
    port                           = 80
  }
}
pool_association = {

  pool_association2 = {
    ip_configuration_name = "mono-backend-dev-ipconfig1"
    nic_name              = "mono-backend-dev-nic"
    rg_name               = "mono-dev-rg"
    lb_name               = "mono-dev-ilb"
    backend_name          = "mono-dev-ilb-pool"
  }
}
associate = {
  associate1 = {
    nsg_name    = "mono-apw-dev-nsg"
    subnet_name = "apw-mono-snet-dev"
    vnet_name   = "mono-dev-vnet"
    rg_name     = "mono-dev-rg"
  }
  associate2 = {
    nsg_name    = "mono-frontend-dev-nsg"
    subnet_name = "frontend-mono-snet-dev"
    vnet_name   = "mono-dev-vnet"
    rg_name     = "mono-dev-rg"
  }
  associate3 = {
    nsg_name    = "mono-backend-dev-nsg"
    subnet_name = "backend-mono-snet-dev"
    vnet_name   = "mono-dev-vnet"
    rg_name     = "mono-dev-rg"
  }
}
agw = {
  agw1 = {
    name              = "mono-dev-agw"
    rg_name           = "mono-dev-rg"
    subnet_name       = "apw-mono-snet-dev"
    vnet_name         = "mono-dev-vnet"
    public_ip_address = "mono-dev-pip"


    sku = {
      name = "Standard_v2"
      tier = "Standard_v2"
    }

    autoscale_configuration = {
      min_capacity = 1
      max_capacity = 5
    }

    gateway_ip_configuration = {
      name = "mono-dev-agw-gateway-ipconfig"
    }

    frontend_ip_configuration = {
      frontend1 = {
        name              = "mono-dev-agw-frontend-ipconfig"
        public_ip_address = "mono-dev-pip"
      }
    }

    frontend_port = {
      port1 = {
        name = "mono-dev-agw-frontend-port"
        port = 80
      }
    }

    backend_address_pool = {
      pool1 = {
        name = "mono-dev-agw-backend-pool"
      }
    }
    probe = {
      probe1 = {
        name                                      = "mono-dev-agw-probe"
        protocol                                  = "Http"
        path                                      = "/"
        interval                                  = 30
        timeout                                   = 30
        unhealthy_threshold                       = 3
        pick_host_name_from_backend_http_settings = true
      }
    }
    backend_http_settings = {
      settings1 = {
        name                  = "mono-dev-agw-backend-http-settings"
        cookie_based_affinity = "Disabled"
        port                  = 80
        protocol              = "Http"
        request_timeout       = 20
      }
    }
    http_listener = {
      listener1 = {
        name                           = "mono-dev-agw-http-listener"
        frontend_ip_configuration_name = "mono-dev-agw-frontend-ipconfig"
        frontend_port_name             = "mono-dev-agw-frontend-port"
        protocol                       = "Http"
      }
    }
    request_routing_rule = {
      rule1 = {
        name                       = "mono-dev-agw-request-routing-rule"
        priority                   = 100
        rule_type                  = "Basic"
        http_listener_name         = "mono-dev-agw-http-listener"
        backend_address_pool_name  = "mono-dev-agw-backend-pool"
        backend_http_settings_name = "mono-dev-agw-backend-http-settings"
      }
    }
  }
}
agw_pool_association = {
  pool_association1 = {
    ip_configuration_name   = "mono-frontend-dev-ipconfig"
    nic_name                = "mono-frontend-dev-nic"
    rg_name                 = "mono-dev-rg"
    agw_name                = "mono-dev-agw"
    backend_name            = "mono-dev-agw-backend-pool"
  }
}
