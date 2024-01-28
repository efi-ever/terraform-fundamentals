# Building a Terraform Module - Networking (WIP)

In this challenge, you will start building a Terraform module that can deploy resources using Azure.

To define a module, we must create a designated directory to house all of the .tf files that make up the module. For this challenge, this directory has already been created for you, called terraform-azure-modules.

To begin, open the file called networking.tf in the terraform-azure-modules directory. This file, will initially contain the necessary Terraform code to deploy an AWS VPC and an AWS subnet. Copy the below snippet into networking.tf

``` bash
#networking.tf

# networking.tf

resource "azurerm_virtual_network" "lab" {
  name                = "lab-vnet"
  address_space       = [var.azure_vpc_cidr_block]
  location            = var.azure_region
  resource_group_name = var.azure_resource_group
}

resource "azurerm_subnet" "lab_subnet" {
  name                 = "lab-subnet"
  resource_group_name  = azurerm_virtual_network.lab.resource_group_name
  virtual_network_name = azurerm_virtual_network.lab.name
  address_prefixes     = [var.azure_subnet_cidr_block]
}

resource "azurerm_network_interface" "lab_interface" {
  name                      = "lab-nic"
  location                  = var.azure_region
  resource_group_name       = var.azure_resource_group

  ip_configuration {
    name                          = "lab-ipconfig"
    subnet_id                     = azurerm_subnet.lab_subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}
```

In the above code, notice a couple variables used. In order to use these variables, they must be defined. Open the file variables.tf and paste the below snippet which defines the variables used above:


``` bash
#variables.tf

variable "azure_vpc_cidr_block" {
  type        = string
  default     = "10.0.0.0/16"
  description = "The CIDR block to use for the VNet."
}

variable "azure_subnet_cidr_block" {
  type        = string
  default     = "10.0.1.0/24"
  description = "The CIDR block to use for the subnet."
}

variable "azure_region" {
  type        = string
  default     = "East US"  # Set your desired Azure region
  description = "The Azure region to deploy the resources."
}

variable "azure_resource_group" {
  type        = string
  default     = "your_resource_group_name"  # Set your desired Azure resource group
  description = "The Azure resource group to deploy the resources."
}

```

The above code will create an interface for us that will live on the subnet and consequently, the VPC we have defined.

Once copied, ensure you have saved both files. Your directory structure should look like this:

``` bash
.
└── terraform-azure-modules
    ├── networking.tf
    └── variables.tf

```

You can now move to the next challenge where you will define the compute part of the module.

# Building a Terraform Module - Compute

In this challenge, you will build off of the code in the last challenge and now write the terraform code to deploy EC2 instances.

Ensure you are in the terraform-azure-modules directory and then create a file called data.tf. This file will contain the code that uses Terraform's data resource to do an AMI lookup and return the latest Ubuntu 20.04 image for us. Copy the below snippet into data.tf:

``` bash
# data.tf

data "azurerm_image" "ubuntu" {
  name                = "UbuntuServer"
  publisher           = "Canonical"
  offer               = "UbuntuServer"
  sku                 = "20.04-LTS"
  version             = "latest"
}

```

Once saved, you can now move to the code that will use both your recent data resource as well as the interface resource from the previous challenge to build machines. Create a file called vm.tf and copy the below snippet of code:

``` bash
# vm.tf

resource "azurerm_linux_virtual_machine" "server" {
  name                  = "server-vm"
  resource_group_name   = var.azure_resource_group
  location              = var.azure_region
  size                  = var.azure_vm_size
  admin_username        = var.azure_vm_admin_username
  admin_password        = var.azure_vm_admin_password
  network_interface_ids = [azurerm_network_interface.lab_interface.id]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = data.azurerm_image.ubuntu.publisher
    offer     = data.azurerm_image.ubuntu.offer
    sku       = data.azurerm_image.ubuntu.sku
    version   = data.azurerm_image.ubuntu.version
  }
}

```

Save the file. Create the variables.tf file and append the below snippet of code:

``` bash
# variables.tf

variable "azure_vm_size" {
  type        = string
  default     = "Standard_B1s"
  description = "The Azure VM size for the instance."
}

variable "azure_vm_admin_username" {
  type        = string
  default     = "adminuser"
  description = "The admin username for the VM."
}

variable "azure_vm_admin_password" {
  type        = string
  default     = "Password123!"  # Set your desired admin password
  description = "The admin password for the VM."
}
```

Once saved, you will have successfully written the code for your AWS module. Checking in, ensure your directory structure looks like this:

``` bash
.
└── terraform-azure-modules
    ├── data.tf
    ├── vm.tf
    ├── networking.tf
    └── variables.tf
```

You can now move to the next challenge where you will define an output for your module and create a short README.

# Building a Terraform Module - Output and README

In this challenge, you will finish building your Terraform module with an output and a README.

Recall, an output in Terraform is a way to return values and can also be used to pass values from one module to another. In our case, by defining an output we are passing a value from our child module, to the root.

In the terraform-azure-modules directory, create the outputs.tf file and copy the snippet below. This will return the IP address that is assigned to the network interface on the created Azure VM.

``` bash
# outputs.tf

output "instance_ip_addr" {
  value = azurerm_linux_virtual_machine.server.private_ip_address
}
```

Once saved, the last item to look at is the README. It is important to add documentation to your modules so that users can use it quickly and efficiently. A good README has details such as:

``` bash
    the providers it uses
    any dependent modules
    resources used
    any inputs or outputs
```

A handy tool to easily generate READMEs can be found here (https://github.com/terraform-docs/terraform-docs).

A README as already been generated for you and can be found by opening the README.md file in your module directory.

Once you have reviewed it, you can move onto the next challenge where you will use your module to provision Azure resources.

# Building a Terraform Module - Using Your Module

In the last few challenges, you built a module that builds an Azure Virtual Machine. In this challenge, you will now use that module to actually build the infrastructure in Azure.

To begin, the first file we will write is the main.tf file. This file will contain the code to call our module and populate the variables it has as inputs. Copy the below snippet into the main.tf file:

``` bash
# main.tf

module "terraform-azure-vm" {
  source                 = "./terraform-azure-vm"
  azure_vpc_cidr_block   = "10.0.0.0/16"
  azure_subnet_cidr_block = "10.0.1.0/24"
  azure_vm_size          = "Standard_B1s"
  azure_vm_admin_username = "adminuser"
  azure_vm_admin_password = "Password123!"
}
```

The next file we will write is our provider.tf and we will use this to define the Terraform provider our module uses, which in this case, is just the AWS one. Copy the below snippet in provider.tf:

``` bash
# provider.tf

provider "azurerm" {
  features = {}
}
```

Finally, because our module has an output, we can reference it here so that, when we run an apply, we will get the output of our module displayed. Referencing a module's output uses the following syntax: module.<MODULE_NAME>.<OUTPUT_NAME>.

To specify the output variable in our case, copy the following snippet into the file outputs.tf:

``` bash
# outputs.tf

output "instance_ip_addr" {
  value = module.terraform-azure-vm.instance_ip_addr
}
```

Once done, ensure all files are saved and your directory should have the structure as shown below:

``` bash
.
└── terraform-azure-vm
    ├── README.md
    ├── data.tf
    ├── vm.tf
    ├── networking.tf
    ├── outputs.tf
    └── variables.tf
```

When you are ready, you can test your module! First, run a terraform init to have Terraform initialize your workspace and module. Once initialized, you can run a plan and finally apply to verify that Terraform will create the desired resources.

After your apply completes, you will see the internal IP address of your newly created EC2 instance and you will have successfully created your first Terraform module!