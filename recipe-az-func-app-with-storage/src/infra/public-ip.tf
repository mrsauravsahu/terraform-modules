resource "azurerm_public_ip" "apim" {
  name                = "${var.app.name}-apim-public-ip-${random_string.func_name.result}"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  allocation_method   = "Static"
}
