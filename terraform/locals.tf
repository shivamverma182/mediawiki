locals {
  db = {
    db-name     = module.mysql.database[0]
    db-host     = module.mysql.mysql_server.name
    db-password = module.mysql.password
    db-user     = var.administrator_login
  }
}
