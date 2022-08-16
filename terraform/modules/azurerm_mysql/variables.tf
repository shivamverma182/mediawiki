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

variable "auto_grow_enabled" {
  description = "Enable/Disable auto-growing of the storage."
  type        = bool
  default     = false
}

variable "storage_mb" {
  description = "Max storage allowed for a server. Possible values are between 5120 MB(5GB) and 1048576 MB(1TB) for the Basic SKU and between 5120 MB(5GB) and 4194304 MB(4TB) for General Purpose/Memory Optimized SKUs."
  type        = number
  default     = 5120
}

variable "backup_retention_days" {
  description = "Backup retention days for the server, supported values are between 7 and 35 days."
  type        = number
  default     = 10
}

variable "geo_redundant_backup_enabled" {
  description = "Turn Geo-redundant server backups on/off. Not available for the Basic tier."
  type        = bool
  default     = false
}

variable "mysql_version" {
  description = "Valid values are 5.6, 5.7 and 8.0"
  type        = string
  default     = "8.0"
}

variable "force_ssl" {
  description = "Enforce SSL connection"
  type        = bool
  default     = true
}

variable "force_ssl_minimal_version" {
  description = "The minimal SSL version enforced"
  type        = string
  default     = "TLS1_2"
  validation {
    condition     = contains(["TLSEnforcementDisabled", "TLS1_1", "TLS1_2"], var.force_ssl_minimal_version)
    error_message = "Valid values for var: force_ssl_minimal_version are (TLSEnforcementDisabled, TLS1_1, TLS1_2)."
  }
}

variable "databases" {
  description = "Map of databases with default collation and charset"
  type        = map(map(string))
}

variable "public_network_access_enabled" {
  type        = bool
  description = "Enable public network access for this server"
  default     = true
}

variable "threat_detection_policy" {
  type        = any
  description = "Threat detection policy configuration, known in the API as Server Security Alerts Policy"
  default     = null
}

variable "mysql_server_name" {}

variable "sku" {}

variable "tags" { default = {} }
variable "allowed_cidrs" {
  description = "Map of authorized cidrs"
  type        = map(string)
  default     = {}
}

variable "allowed_subnets" {
  type        = map(string)
  description = "Map of authorized subnet ids"
  default     = {}
}
