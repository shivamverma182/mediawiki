terraform {
  required_version = ">= 1.0.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 2.0.0"
    }
    mysql = {
      source  = "petoju/mysql"
      version = "~> 3.0.18"
    }
  }
}

provider "azurerm" {
  features {}
}

# provider "mysql" {
#   endpoint = azurerm_mysql_flexible_server.this.fqdn
#   username = "myadmin"
#   password = random_password.this.result
# }
