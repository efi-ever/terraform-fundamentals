variable "resource_group_name" {
  description = "The name of the resource group in which to create the storage account."
}

variable "storage_account_name" {
  description = "The name of the storage account."
}

variable "location" {
  description = "The location for the storage account."
}

resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_storage_account" "storage" {
  name                     = var.storage_account_name
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

output "name" {
  value = azurerm_storage_account.storage.name
}
