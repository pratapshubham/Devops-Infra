virtual_machine = {
  virtual_machine_dev = {
    name                = "shubham-vm-dev"
    resource_group_name = "shubham_rg_test"
    location            = "centralindia"
    vm_size             = "Standard_B2s"
    os_type             = "Linux"
    image_publisher     = "Canonical"
    image_offer         = "0001-com-ubuntu-server-jammy"
    image_sku           = "22_04-lts-gen2"
    image_version       = "latest"
    admin_username      = "azureuser"
    admin_password      = "Shubham1111@@@@"
    subnet_id           = "/subscriptions/3cd5f8e1-c22f-4e10-9475-157bc83ef501/resourceGroups/shubham_rg_test/providers/Microsoft.Network/virtualNetworks/shubham-vnet-dev/subnets/dev-subnet"
    public_ip_needed    = true
  }

  virtual_machine_prod = {
    name                = "shubham-vm-prod"
    resource_group_name = "shubham_rg_test1"
    location            = "centralindia"
    vm_size             = "Standard_D2s_v3"
    os_type             = "Linux"
    image_publisher     = "Canonical"
    image_offer         = "UbuntuServer"
    image_sku           = "24.04-LTS"
    image_version       = "latest"
    admin_username      = "azureuser"
    admin_password      = "Shubham1111@@@@"
    subnet_id           = "/subscriptions/3cd5f8e1-c22f-4e10-9475-157bc83ef501/resourceGroups/shubham_rg_test1/providers/Microsoft.Network/virtualNetworks/shubham-vnet-prod/subnets/prod-subnet"
    public_ip_needed    = true
  }
}