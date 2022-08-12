resource "random_password" "mysql" {
  length = 12
}

resource "azurerm_resource_group" "mysql" {
  location = var.location
  name     = var.resource_group_name
}

resource "azurerm_mysql_server" "mysql_server" {
  name                             = var.mysql_server_name
  location                         = azurerm_resource_group.mysql.location
  resource_group_name              = azurerm_resource_group.mysql.name
  sku_name                         = var.sku
  backup_retention_days            = var.backup_retention_days
  geo_redundant_backup_enabled     = var.geo_redundant_backup_enabled
  storage_mb                       = var.storage_mb
  auto_grow_enabled                = var.auto_grow_enabled
  administrator_login              = var.administrator_login
  administrator_login_password     = random_password.mysql.result
  version                          = var.mysql_version
  ssl_enforcement_enabled          = var.force_ssl
  ssl_minimal_tls_version_enforced = var.force_ssl_minimal_version
  public_network_access_enabled    = var.public_network_access_enabled
  dynamic "threat_detection_policy" {
    for_each = var.threat_detection_policy != null ? [var.threat_detection_policy] : []
    content {
      enabled                    = lookup(threat_detection_policy.value, "enabled", true)
      disabled_alerts            = lookup(threat_detection_policy.value, "disabled_alerts", [])
      email_account_admins       = lookup(threat_detection_policy.value, "email_account_admins", false)
      email_addresses            = lookup(threat_detection_policy.value, "email_addresses", [])
      retention_days             = lookup(threat_detection_policy.value, "retention_days", 0)
      storage_account_access_key = lookup(threat_detection_policy.value, "storage_account_access_key", null)
      storage_endpoint           = lookup(threat_detection_policy.value, "storage_endpoint", null)
    }
  }
  tags = var.tags
}

resource "azurerm_mysql_database" "mysql_db" {
  for_each = var.databases

  charset             = lookup(each.value, "charset", "utf8")
  collation           = lookup(each.value, "collation", "utf8_general_ci")
  name                = each.key
  resource_group_name = var.resource_group_name
  server_name         = azurerm_mysql_server.mysql_server.name
}
