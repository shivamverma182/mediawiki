output "db_host" {
  description = "FQDN for Azure MySQL server"
  value       = module.mysql.mysql_server.fqdn
}

output "db_user" {
  description = "Administrator user for Azure MySQL server"
  value       = module.mysql.mysql_server.administrator_login
}

output "db_password" {
  description = "Administrator password for Azure MySQL server"
  value       = module.mysql.password
  sensitive   = true
}

output "db_name" {
  description = "database name"
  value       = keys(var.databases)[0]
}

