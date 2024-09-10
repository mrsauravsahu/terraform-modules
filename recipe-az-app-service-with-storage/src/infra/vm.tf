resource "azurerm_linux_virtual_machine" "vm" {
  name                  = "${var.app.prefix}-${var.app.name}-${var.app.env}-vm"
  resource_group_name = azurerm_resource_group.main.name
  location              = azurerm_resource_group.main.location
  size               = "Standard_B4ms"
  disable_password_authentication=false
  admin_username = "<TODO>"
  admin_password = "<TODO>"

  os_disk {
     caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

 source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
  network_interface_ids = [azurerm_network_interface.vm_nic.id]
}
