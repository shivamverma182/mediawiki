output "user" {
  description = "Administrator user for MySQL"
  value       = azurerm_mysql_server.mysql_server.administrator_login
}

output "password" {
  description = "Administrator password for MySQL"
  value       = random_password.mysql.result
  sensitive   = true
}

output "host" {
  description = "FQDN for Azure MySQL Server"
  value       = azurerm_mysql_server.mysql_server.fqdn
}

output "database" {
  description = "MySQL database name"
  value       = keys(var.databases)
}
