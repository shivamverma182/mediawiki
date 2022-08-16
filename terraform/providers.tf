provider "azurerm" {
  features {}
}

terraform {
  experiments = [module_variable_optional_attrs]
}
