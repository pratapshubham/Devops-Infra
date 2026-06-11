# Network Security Group
resource "azurerm_network_security_group" "vm_nsg" {
  for_each = var.virtual_machine

  name                = "${each.value.name}-nsg"
  location            = each.value.location
  resource_group_name = each.value.resource_group_name

  security_rule {
    name                       = "AllowSSH"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "AllowRDP"
    priority                   = 101
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3389"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "AllowHTTP"
    priority                   = 102
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "AllowHTTPS"
    priority                   = 103
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

# Public IPs (conditional)
resource "azurerm_public_ip" "vm_public_ip" {
  for_each = {
    for key, vm in var.virtual_machine : key => vm
    if vm.public_ip_needed
  }

  name                = "${each.value.name}-pip"
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"
}

# Network Interfaces
resource "azurerm_network_interface" "vm_nic" {
  for_each = var.virtual_machine

  name                = "${each.value.name}-nic"
  location            = each.value.location
  resource_group_name = each.value.resource_group_name

  ip_configuration {
    name                          = "${each.value.name}-ipconfig"
    subnet_id                     = each.value.subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = each.value.public_ip_needed ? azurerm_public_ip.vm_public_ip[each.key].id : null
  }
}

# Associate NSG with Network Interface
resource "azurerm_network_interface_security_group_association" "vm_nsg_association" {
  for_each = var.virtual_machine

  network_interface_id      = azurerm_network_interface.vm_nic[each.key].id
  network_security_group_id = azurerm_network_security_group.vm_nsg[each.key].id
}

# Virtual Machines
resource "azurerm_linux_virtual_machine" "vm_linux" {
  for_each = {
    for key, vm in var.virtual_machine : key => vm
    if vm.os_type == "Linux"
  }

  name                = each.value.name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  size                = each.value.vm_size

  admin_username = each.value.admin_username

  admin_ssh_key {
    username   = each.value.admin_username
    public_key = file(pathexpand(var.ssh_public_key_path))
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Premium_LRS"
  }

  source_image_reference {
    publisher = each.value.image_publisher
    offer     = each.value.image_offer
    sku       = each.value.image_sku
    version   = each.value.image_version
  }

  network_interface_ids = [
    azurerm_network_interface.vm_nic[each.key].id,
  ]

  tags = {
    Environment = startswith(each.key, "dev") ? "dev" : "prod"
  }
}

resource "azurerm_windows_virtual_machine" "vm_windows" {
  for_each = {
    for key, vm in var.virtual_machine : key => vm
    if vm.os_type == "Windows"
  }

  name                = each.value.name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  size                = each.value.vm_size

  admin_username = each.value.admin_username
  admin_password = each.value.admin_password

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Premium_LRS"
  }

  source_image_reference {
    publisher = each.value.image_publisher
    offer     = each.value.image_offer
    sku       = each.value.image_sku
    version   = each.value.image_version
  }

  network_interface_ids = [
    azurerm_network_interface.vm_nic[each.key].id,
  ]

  tags = {
    Environment = startswith(each.key, "dev") ? "dev" : "prod"
  }
}