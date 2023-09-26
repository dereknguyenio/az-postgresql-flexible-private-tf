data "azurerm_client_config" "current_client" {}

resource "azurerm_key_vault" "postgresql_tf_key_vault" {
  name                        = "pgsqltf-kv-${var.environment}"
  location                    = azurerm_resource_group.default.location
  resource_group_name         = azurerm_resource_group.default.name
  tenant_id                   = data.azurerm_client_config.current_client.tenant_id
  sku_name                    = "standard"

  tags = local.common_tags
}

resource "azurerm_key_vault_secret" "pgsqltf_windows_vm_password" {
  name         = "PgSqlTfWindowsVmPassword-${var.environment}"
  value        = random_password.windows_vm_password.result
  key_vault_id = azurerm_key_vault.postgresql_tf_key_vault.id

  tags = local.common_tags
}

resource "azurerm_key_vault_secret" "pgsqltf_windows_vm_username" {
  name         = "PgSqlTfWindowsVmUsername-${var.environment}"
  value        = "adminuser"
  key_vault_id = azurerm_key_vault.postgresql_tf_key_vault.id

  tags = local.common_tags
}

resource "azurerm_key_vault_secret" "pgsqltf_postgresql_password" {
  name         = "PgSqlTfPostgresqlPassword-${var.environment}"
  value        = random_password.pass.result
  key_vault_id = azurerm_key_vault.postgresql_tf_key_vault.id

  tags = local.common_tags
}

resource "azurerm_key_vault_secret" "pgsqltf_postgresql_username" {
  name         = "PgSqlTfPostgresqlUsername-${var.environment}"
  value        = "adminTerraform"
  key_vault_id = azurerm_key_vault.postgresql_tf_key_vault.id

  tags = local.common_tags
}

resource "azurerm_key_vault_access_policy" "terraform_sp_access_policy" {
  key_vault_id = azurerm_key_vault.postgresql_tf_key_vault.id
  tenant_id    = data.azurerm_client_config.current_client.tenant_id
  object_id    = data.azurerm_client_config.current_client.object_id

  secret_permissions = [
    "List",
    "Get",
    "Set"
  ]
}

# resource "azurerm_key_vault_access_policy" "example" {
#   key_vault_id = azurerm_key_vault.postgresql_tf_key_vault.id

#   tenant_id = data.azurerm_client_config.example.tenant_id
#   object_id = var.user_object_id

#   secret_permissions = [
#     "list",
#     "get",
#     "set"
#   ]
# }

output "postgresql_tf_key_vault_id" {
  value = azurerm_key_vault.postgresql_tf_key_vault.id
}

output "pgsqltf_windows_vm_password_secret_id" {
  value = azurerm_key_vault_secret.pgsqltf_windows_vm_password.id
}

output "pgsqltf_windows_vm_username_secret_id" {
  value = azurerm_key_vault_secret.pgsqltf_windows_vm_username.id
}

output "pgsqltf_postgresql_password_secret_id" {
  value = azurerm_key_vault_secret.pgsqltf_postgresql_password.id
}

output "pgsqltf_postgresql_username_secret_id" {
  value = azurerm_key_vault_secret.pgsqltf_postgresql_username.id
}
