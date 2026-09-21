terraform {

  backend "azurerm" {

    # Authenticate to Storage using
    # Microsoft Entra credentials.
    use_azuread_auth = true

    # Local development uses our Azure CLI session.
    use_cli = true
  }
}