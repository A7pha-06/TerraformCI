terraform {
  required_version = ">=1.3.0"
  required_providers {
    azurerm = {
      "source" = "hashicorp/azurerm"
      version  = "3.43.0"
    }
  }

  cloud {

    organization = "Sid_CI"

    workspaces {
      name = "CI_CD"
    }
  }


}

provider "azurerm" {
  features {}
  skip_provider_registration = true
}

resource "random_string" "uniquestring" {
  length  = 20
  special = false
  upper   = false
}

resource "azurerm_resource_group" "balena" {
  name     = "1-e28b492e-playground-sandbox"
  location = "East US"
}

resource "azurerm_storage_account" "storageaccount" {
  name                     = "stg${random_string.uniquestring.result}"
  resource_group_name      = azurerm_resource_group.balena.name
  location                 = azurerm_resource_group.balena.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}
