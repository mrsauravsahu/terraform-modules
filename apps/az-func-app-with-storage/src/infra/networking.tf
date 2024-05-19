locals {
  nsg_rules = [
    # Inbound Rules
    [ "80", "Inbound", "TODO", "VirtualNetwork" ],
    [ "3443", "Inbound", "TODO", "VirtualNetwork" ],
    [ "6390", "Inbound", "TODO", "VirtualNetwork" ],
    [ "443", "Inbound", "TODO", "VirtualNetwork" ],
    # Outbound Rules
    [ "1433", "Outbound", "TODO", "TODO" ],
    [ "443", "Outbound", "TODO", "TODO" ],
    [ "1886", "Outbound", "TODO", "TODO" ],
    [ "443", "Outbound", "TODO", "TODO" ],
  ]
}

resource "azurerm_virtual_network" "main" {
  name                = "${var.app.name}-vnet-${random_string.func_name.result}"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  address_space       = ["10.0.0.0/16"]
  dns_servers         = ["10.0.0.4", "10.0.0.5"]
}

resource "azurerm_subnet" "apim" {
  name                 = "${var.app.name}-subnet-apim-${random_string.func_name.result}"
  resource_group_name  = azurerm_resource_group.main.name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_network_security_group" "apim" {
  name                = "${var.app.name}-nsg-${random_string.func_name.result}"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name

  # https://learn.microsoft.com/en-us/azure/api-management/api-management-using-with-vnet?tabs=stv2

  dynamic "security_rule" {
    for_each = local.nsg_rules
    content {
      name                       = "NSGRule-${security_rule.value[1]}-${security_rule.value[0]}"
      priority                   = 100 + index(local.nsg_rules, security_rule.value)
      direction                  = security_rule.value[1]
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = security_rule.value[0]
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    }
  }
}

resource "azurerm_subnet_network_security_group_association" "main" {
  subnet_id                 = azurerm_subnet.apim.id
  network_security_group_id = azurerm_network_security_group.apim.id
}
