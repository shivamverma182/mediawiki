variable "location" {
  description = "Azure location."
  type        = string
}

variable "resource_group_name" {
  description = "Resource group name"
  type        = string
}

variable "administrator_login" {
  description = "MySQL administrator login"
  type        = string
}

variable "databases" {
  description = "Map of databases with default collation and charset"
  type        = map(map(string))
}

variable "mysql_server_name" {}

variable "sku" {}

variable "force_ssl" {
  description = "Enforce SSL connection"
  type        = bool
  default     = true
}

variable "allowed_cidrs" {
  description = "Map of authorized cidrs"
  type        = map(string)
  default     = {}
}
