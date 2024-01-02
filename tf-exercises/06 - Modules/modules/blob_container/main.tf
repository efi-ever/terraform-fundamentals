variable "storage_account_name" {
  description = "The name of the storage account."
}

variable "container_name" {
  description = "The name of the blob container."
}

resource "azurerm_storage_container" "container" {
  name                  = var.container_name
  storage_account_name  = var.storage_account_name
  container_access_type = "private"
}

output "name" {
  value = azurerm_storage_container.container.name
}
