provider "azurerm" {
  features {}

  subscription_id = var.subscription_id
}


# Identify the currently authenticated Azure identity.
data "azurerm_client_config" "current" {}


# Generate characters so that our storage account name
# is globally unique.
resource "random_string" "suffix" {

  length  = 6
  upper   = false
  special = false
}


# -------------------------------------
# TERRAFORM STATE RESOURCE GROUP
# -------------------------------------

resource "azurerm_resource_group" "tfstate" {

  name     = "rg-terraform-state"
  location = var.location
}


# -------------------------------------
# STORAGE ACCOUNT
# -------------------------------------

resource "azurerm_storage_account" "tfstate" {

  name = "sttf${random_string.suffix.result}"

  resource_group_name = azurerm_resource_group.tfstate.name

  location = azurerm_resource_group.tfstate.location

  account_tier = "Standard"

  account_replication_type = "LRS"

  min_tls_version = "TLS1_2"

  tags = {
    Purpose   = "TerraformState"
    ManagedBy = "Terraform"
  }
}


# -------------------------------------
# STATE CONTAINER
# -------------------------------------

resource "azurerm_storage_container" "tfstate" {

  name = "tfstate"

  storage_account_id = azurerm_storage_account.tfstate.id

  container_access_type = "private"
}


# Terraform will authenticate to the Storage
# data plane through Microsoft Entra ID.
resource "azurerm_role_assignment" "tfstate" {

  scope = azurerm_storage_account.tfstate.id

  role_definition_name = "Storage Blob Data Contributor"

  principal_id = data.azurerm_client_config.current.object_id
}