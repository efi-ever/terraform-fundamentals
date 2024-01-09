terraform {
  backend "local" {
  }
}

provider "azurerm" {
  features {}
}

locals {
  name = "world"
}

output "message" {
  value = "Hello ${local.name}, unique_id (${var.unique_id}) in `${terraform.workspace}` environment"
}