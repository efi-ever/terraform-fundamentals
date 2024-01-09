variable "storage_account_type" {
  type    = string
  default = "standard"
}

resource "azurerm_storage_account" "example_storage" {
  name                     = "examplestorage"
  account_tier             = var.storage_account_type == "premium" ? "Premium" : "Standard"
  account_replication_type = var.storage_account_type == "premium" ? "ZRS" : "GRS"
  resource_group_name      = "example-resource-group"
  location                 = "East US"
}
