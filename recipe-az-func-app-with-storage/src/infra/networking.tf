resource "azurerm_virtual_network" "main" {
  name                = "${var.app.prefix}-${var.app.name}-${var.app.env}-vnet-${random_string.func_name.result}"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  address_space       = ["10.0.0.0/16"]
  dns_servers         = ["10.0.0.4", "10.0.0.5"]
}

resource "azurerm_subnet" "funcapp" {
  name                 = "${var.app.prefix}-${var.app.name}-${var.app.env}-funcapp-${random_string.func_name.result}"
  resource_group_name  = azurerm_resource_group.main.name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = ["10.0.1.0/24"]
}
