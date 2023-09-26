# Existing Resource Group and Virtual Network
data "azurerm_resource_group" "existing_rg" {
  name = azurerm_resource_group.default.name
}

data "azurerm_virtual_network" "existing_vnet" {
  name                = azurerm_virtual_network.default.name
  resource_group_name = azurerm_resource_group.default.name
}

# Public IP for Bastion
resource "azurerm_public_ip" "bastion_public_ip" {
  name                = "bastionPublicIP"
  location            = azurerm_resource_group.default.location
  resource_group_name = azurerm_resource_group.default.name
  allocation_method   = "Static"
  sku                 = "Standard"
  tags                = local.common_tags
}

# Bastion Subnet
resource "azurerm_subnet" "bastion_subnet" {
  name                 = "AzureBastionSubnet"
  resource_group_name  = azurerm_resource_group.default.name
  virtual_network_name = azurerm_virtual_network.default.name
  address_prefixes     = ["10.0.3.0/24"]
}

# Bastion Host
resource "azurerm_bastion_host" "bastion" {
  name                = "example-bastion"
  location            = azurerm_resource_group.default.location
  resource_group_name = azurerm_resource_group.default.name
  tags                = local.common_tags

  ip_configuration {
    name                 = "configuration"
    subnet_id            = azurerm_subnet.bastion_subnet.id
    public_ip_address_id = azurerm_public_ip.bastion_public_ip.id
  }
}

# Separate Subnet for Windows VM
resource "azurerm_subnet" "windows_vm_subnet" {
  name                 = "windows-vm-subnet"
  resource_group_name  = azurerm_resource_group.default.name
  virtual_network_name = azurerm_virtual_network.default.name
  address_prefixes     = ["10.0.4.0/24"]
}

# Network Interface for Windows VM
resource "azurerm_network_interface" "example_nic" {
  name                = "example-nic"
  location            = azurerm_resource_group.default.location
  resource_group_name = azurerm_resource_group.default.name
  tags                = local.common_tags

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.windows_vm_subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}

# Windows VM Configuration
resource "azurerm_windows_virtual_machine" "example" {
  name                = "example-machine"
  resource_group_name = azurerm_resource_group.default.name
  location            = azurerm_resource_group.default.location
  size                = "Standard_DS1_v2"
  tags                = local.common_tags

  network_interface_ids = [
    azurerm_network_interface.example_nic.id
  ]

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2016-Datacenter"
    version   = "latest"
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  admin_username = "adminuser"
  admin_password = "P@$$w0rd123!"
  computer_name  = "example-machine"
}
