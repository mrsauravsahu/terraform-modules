resource "azurerm_virtual_network" "main" {
  name                = "${var.app.prefix}-${var.app.stage}-vnet"
  address_space       = ["10.0.0.0/16"]
  location            = var.location
  resource_group_name = local.resource_group_name
}

resource "azurerm_subnet" "private" {
  name                 = "private"
  resource_group_name  = local.resource_group_name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = ["10.0.0.0/24"]

  enforce_private_link_service_network_policies = true
}
