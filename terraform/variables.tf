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

variable "force_ssl_minimal_version" {
  description = "The minimal SSL version enforced"
  type        = string
  default     = "TLS1_2"
}


variable "allowed_cidrs" {
  description = "Map of authorized cidrs"
  type        = map(string)
  default     = {}
}

variable "keyvault" {
  type = object({
    name                            = string
    sku_name                        = string
    enable_for_deployment           = optional(bool)
    enabled_for_disk_encryption     = optional(bool)
    enabled_for_template_deployment = optional(bool)
    default_action                  = string
    ip_rules                        = optional(list(string))
    virtual_network_subnet_ids      = optional(list(string))
  })
}
