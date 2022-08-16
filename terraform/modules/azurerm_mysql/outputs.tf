output "mysql_server" {
  value = azurerm_mysql_server.mysql_server
}

output "password" {
  description = "Administrator password for MySQL"
  value       = random_password.mysql.result
  sensitive   = true
}

output "database" {
  description = "MySQL database name"
  value       = keys(var.databases)
}
