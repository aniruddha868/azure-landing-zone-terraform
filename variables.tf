variable "resource_group_name" {
  description = "Name of the resource group."
  type        = string
  default     = "rg-azure-landing-zone-dev"
}

variable "location" {
  description = "Azure region for resources."
  type        = string
  default     = "Central India"
}

variable "vnet_name" {
  description = "Virtual Network name."
  type        = string
  default     = "vnet-landing-zone-dev"
}

variable "vnet_address_space" {
  description = "Virtual Network address space."
  type        = list(string)
  default     = ["10.20.0.0/16"]
}

variable "app_subnet_prefix" {
  description = "Application subnet CIDR."
  type        = string
  default     = "10.20.1.0/24"
}

variable "data_subnet_prefix" {
  description = "Data subnet CIDR."
  type        = string
  default     = "10.20.2.0/24"
}

variable "log_analytics_workspace_name" {
  description = "Log Analytics Workspace name."
  type        = string
  default     = "law-landing-zone-dev"
}

variable "log_retention_in_days" {
  description = "Workspace data retention in days."
  type        = number
  default     = 30

  validation {
    condition     = var.log_retention_in_days >= 30 && var.log_retention_in_days <= 730
    error_message = "Log retention must be between 30 and 730 days."
  }
}

variable "key_vault_name_prefix" {
  description = "Short globally unique prefix for the Key Vault name (3-15 lowercase letters/numbers/hyphens)."
  type        = string
  default     = "ankurhekv"

  validation {
    condition     = length(var.key_vault_name_prefix) >= 3 && length(var.key_vault_name_prefix) <= 15 && can(regex("^[a-z0-9-]+$", var.key_vault_name_prefix))
    error_message = "Use 3-15 lowercase letters, numbers, or hyphens for the Key Vault prefix."
  }
}

variable "key_vault_allowed_ip_cidrs" {
  description = "Optional public IP CIDRs allowed to reach Key Vault, e.g. [\"203.0.113.10/32\"]. Empty means network ACL default deny blocks public client access."
  type        = list(string)
  default     = []
}

variable "tags" {
  description = "Common resource tags."
  type        = map(string)
  default = {
    environment = "dev"
    managed_by  = "terraform"
    project     = "azure-landing-zone"
    owner       = "aniruddha-kurhe"
  }
}
