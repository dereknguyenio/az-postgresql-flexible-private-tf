# Output the Resource Group name
output "resource_group_name" {
  value = azurerm_resource_group.default.name
  description = "The name of the Resource Group."
}

output "azurerm_postgresql_flexible_server" {
  value = azurerm_postgresql_flexible_server.default.name
}

output "postgresql_flexible_server_database_name" {
  value = azurerm_postgresql_flexible_server_database.default.name
}

output "postgresql_flexible_server_admin_password" {
  sensitive = true
  value     = azurerm_postgresql_flexible_server.default.administrator_password
}

output "postgresql_flexible_server_admin_login" {
  value     = azurerm_postgresql_flexible_server.default.administrator_login
}


# Output the public IP address of the Bastion host
output "bastion_public_ip" {
  value = azurerm_public_ip.bastion_public_ip.ip_address
  description = "The public IP address of the Bastion host."
}

# Output the private IP address of the Windows VM
output "windows_vm_private_ip" {
  value = azurerm_network_interface.example_nic.private_ip_address
  description = "The private IP address of the Windows VM."
}

# Output the Virtual Network name
output "virtual_network_name" {
  value = azurerm_virtual_network.default.name
  description = "The name of the Virtual Network."
}
