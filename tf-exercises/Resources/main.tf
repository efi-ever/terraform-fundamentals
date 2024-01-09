#this script creates a resource group in Azure. 
resource "azurerm_resource_group" "rg" {
  name     = "rg-${unique_id}"
  location = "eu-north"
}