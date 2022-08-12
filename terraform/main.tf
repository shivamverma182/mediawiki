module "mysql" {
  source = "./modules"

  resource_group_name = var.resource_group_name
  location            = var.location
  administrator_login = var.administrator_login
  databases           = var.databases
  mysql_server_name   = var.mysql_server_name
  sku                 = var.sku
  force_ssl           = var.force_ssl
  allowed_cidrs       = var.allowed_cidrs
}



/*

administrator_login = "myadmin"
location            = "UK South"
resource_group_name = "mytest-rg"
databases = {
  "wikidatabase" = {}
}
mysql_server_name = "my-test-mysql"
sku               = "B_Gen5_2"
force_ssl         = false
allow_ip          = "100.100.100.100"

*/
