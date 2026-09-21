# Find details about the authenticated identity.
data "azurerm_client_config" "current" {}


# Short random suffix for globally unique resources
# such as Key Vault.
resource "random_string" "suffix" {

  length  = 5
  upper   = false
  special = false
}


locals {

  common_tags = {

    Environment = var.environment

    Project = var.project_name

    ManagedBy = "Terraform"
  }
}


# -------------------------------------
# RESOURCE GROUP
# -------------------------------------

resource "azurerm_resource_group" "main" {

  name = "rg-${var.project_name}-${var.environment}"

  location = var.location

  tags = local.common_tags
}


# -------------------------------------
# NETWORK MODULE
# -------------------------------------

module "network" {

  source = "../../modules/network"

  resource_group_name = azurerm_resource_group.main.name

  location = azurerm_resource_group.main.location

  vnet_name = "vnet-${var.project_name}-${var.environment}"

  address_space = var.vnet_address_space

  subnets = var.subnets

  tags = local.common_tags
}


# -------------------------------------
# LOG ANALYTICS
# -------------------------------------

resource "azurerm_log_analytics_workspace" "main" {

  name = "law-${var.project_name}-${var.environment}"

  location = azurerm_resource_group.main.location

  resource_group_name = azurerm_resource_group.main.name

  sku = "PerGB2018"

  retention_in_days = 30

  tags = local.common_tags
}


# -------------------------------------
# KEY VAULT
# -------------------------------------

resource "azurerm_key_vault" "main" {

  name = "kv-${var.project_name}-${var.environment}-${random_string.suffix.result}"

  location = azurerm_resource_group.main.location

  resource_group_name = azurerm_resource_group.main.name

  tenant_id = data.azurerm_client_config.current.tenant_id

  sku_name = "standard"

  rbac_authorization_enabled = true

  soft_delete_retention_days = 7

  purge_protection_enabled = false

  tags = local.common_tags
}