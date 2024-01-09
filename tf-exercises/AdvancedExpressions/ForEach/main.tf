//TODO: Also, you need to create the network interface azurerm_network_interface.example and the resource group example-resource-group before creating the virtual machines - maybe exercise idea?

variable "regions" {
  type    = map(string)
  default = {
    us_west     = "West US"
    us_east     = "East US"
    europe_west  = "West Europe"
  }
}

resource "azurerm_virtual_machine" "example_vm" {
    for_each = var.regions

    name                  = "example-vm-${each.key}"
    location              = each.value
    resource_group_name   = "example-resource-group"
    vm_size               = "Standard_DS1_v2"

    delete_os_disk_on_termination = true

    storage_image_reference {
        publisher = "Canonical"
        offer     = "UbuntuServer"
        sku       = "20.04-LTS"
        version   = "latest"
    }

    storage_os_disk {
        name              = "osdisk"
        caching           = "ReadWrite"
        create_option     = "FromImage"
    }

    os_profile {
        computer_name  = "hostname"
        admin_username = "admin"
    }

    network_interface_ids = [azurerm_network_interface.example.id]
}
