# README.md

# Terraform Azure Virtual Machine Module

This Terraform module deploys an Azure Virtual Machine (VM) along with associated networking components.

## Requirements

No requirements.

## Providers

- AzureRM

## Resources

- `azurerm_virtual_network`: Creates a virtual network.
- `azurerm_subnet`: Creates a subnet within the virtual network.
- `azurerm_network_interface`: Creates a network interface for the VM.
- `azurerm_linux_virtual_machine`: Creates an Azure Linux Virtual Machine.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| `azure_vpc_cidr_block` | The CIDR block to use for the VNet. | `string` | n/a | yes |
| `azure_subnet_cidr_block` | The CIDR block to use for the subnet. | `string` | n/a | yes |
| `azure_region` | The Azure region to deploy the resources. | `string` | n/a | yes |
| `azure_resource_group` | The Azure resource group to deploy the resources. | `string` | n/a | yes |
| `azure_vm_size` | The Azure VM size for the instance. | `string` | n/a | yes |
| `azure_vm_admin_username` | The admin username for the VM. | `string` | n/a | yes |
| `azure_vm_admin_password` | The admin password for the VM. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| `instance_ip_addr` | The private IP address assigned to the Azure VM. |

## Usage

```hcl
module "azure_ec2" {
  source                 = "./modules/terraform-azure-ec2"
  azure_vpc_cidr_block   = "10.0.0.0/16"
  azure_subnet_cidr_block = "10.0.1.0/24"
  azure_region           = "East US"
  azure_resource_group   = "your_resource_group_name"
  azure_vm_size          = "Standard_B1s"
  azure_vm_admin_username = "adminuser"
  azure_vm_admin_password = "Password123!"
}
