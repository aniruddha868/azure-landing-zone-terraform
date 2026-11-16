resource "azurerm_resource_group" "landing_zone" {
  name     = var.resource_group_name
  location = var.location
  tags     = var.tags
}

module "networking" {
  source              = "./modules/networking"
  resource_group_name = azurerm_resource_group.landing_zone.name
  location            = azurerm_resource_group.landing_zone.location
  vnet_name           = var.vnet_name
  address_space       = var.vnet_address_space
  app_subnet_prefix   = var.app_subnet_prefix
  data_subnet_prefix  = var.data_subnet_prefix
  tags                = var.tags
}

module "monitoring" {
  source              = "./modules/monitoring"
  resource_group_name = azurerm_resource_group.landing_zone.name
  location            = azurerm_resource_group.landing_zone.location
  workspace_name      = var.log_analytics_workspace_name
  retention_in_days   = var.log_retention_in_days
  tags                = var.tags
}

module "security" {
  source                     = "./modules/security"
  resource_group_name        = azurerm_resource_group.landing_zone.name
  location                   = azurerm_resource_group.landing_zone.location
  key_vault_name_prefix      = var.key_vault_name_prefix
  allowed_ip_cidrs           = var.key_vault_allowed_ip_cidrs
  tags                       = var.tags
}
