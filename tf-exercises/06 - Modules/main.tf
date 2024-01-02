provider "azurerm" {
  features = {}
}

module "storage_account" {
  source              = "./modules/storage_account"
  resource_group_name = "my-resource-group"
  storage_account_name = "mystorageaccount"
  location            = "East US"
}

module "blob_container" {
  source              = "./modules/blob_container"
  storage_account_name = module.storage_account.name
  container_name      = "mycontainer"
}
