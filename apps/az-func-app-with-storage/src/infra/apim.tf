resource "azurerm_api_management" "main" {
  name                = "${var.app.name}-apim1-${random_string.func_name.result}"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  publisher_name      = "Saurav Sahu"
  publisher_email     = "mrsauravsahu@outlook.com"

  sku_name = "Developer_1"

  virtual_network_type = "Internal"
  virtual_network_configuration {
    subnet_id = azurerm_subnet.apim.id
  }

  identity {
    type = "SystemAssigned"
  }
}
