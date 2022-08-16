administrator_login = "myadmin"
location            = "Central India"
resource_group_name = "mytest-rg"
databases = {
  "wikidatabase" = {}
}
mysql_server_name = "my-test-mysql"
sku               = "B_Gen5_2"
force_ssl         = true

allowed_cidrs = {
  "kuberenetes" = "103.95.83.165/32"
}

keyvault = {
  sku_name       = "standard"
  default_action = "Allow"
  name           = "mediawiki-kv"
}
