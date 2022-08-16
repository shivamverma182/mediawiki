resource "azurerm_resource_group" "mysql" {
  location = var.location
  name     = var.resource_group_name
}

module "mysql" {
  source = "./modules/azurerm_mysql"

  resource_group_name       = azurerm_resource_group.mysql.name
  location                  = azurerm_resource_group.mysql.location
  administrator_login       = var.administrator_login
  databases                 = var.databases
  mysql_server_name         = var.mysql_server_name
  sku                       = var.sku
  force_ssl                 = var.force_ssl
  allowed_cidrs             = var.allowed_cidrs
  mysql_version             = "8.0"
  force_ssl_minimal_version = var.force_ssl_minimal_version
}

resource "random_string" "keyvault" {
  length  = 5
  special = false
  lower   = true
}

resource "azurerm_key_vault" "keyvault" {
  location                        = azurerm_resource_group.mysql.location
  name                            = "${var.keyvault.name}-${random_string.keyvault.result}"
  resource_group_name             = azurerm_resource_group.mysql.name
  sku_name                        = var.keyvault.sku_name
  tenant_id                       = data.azurerm_client_config.this.tenant_id
  enable_rbac_authorization       = true
  enabled_for_deployment          = try(var.keyvault.enable_for_deployment, false)
  enabled_for_disk_encryption     = try(var.keyvault.enabled_for_disk_encryption, false)
  enabled_for_template_deployment = try(var.keyvault.enabled_for_template_deployment, false)

  network_acls {
    bypass                     = "AzureServices"
    default_action             = var.keyvault.default_action
    ip_rules                   = try(var.keyvault.ip_rules, [])
    virtual_network_subnet_ids = try(var.keyvault.virtual_network_subnet_ids, [])
  }
}

resource "azurerm_role_assignment" "keyvault" {
  principal_id         = data.azurerm_client_config.this.object_id
  scope                = azurerm_key_vault.keyvault.id
  role_definition_name = "Key Vault Secrets Officer"
}

resource "time_sleep" "propagate" {
  create_duration = "10s"

  depends_on = [
    azurerm_role_assignment.keyvault
  ]
}

resource "azurerm_key_vault_secret" "db" {
  for_each     = local.db
  key_vault_id = azurerm_key_vault.keyvault.id
  name         = "${module.mysql.mysql_server.name}-${each.key}"
  value        = each.value

  depends_on = [
    time_sleep.propagate
  ]
}
