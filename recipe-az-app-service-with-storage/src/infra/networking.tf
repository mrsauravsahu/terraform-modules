resource "azurerm_virtual_network" "main" {
  name                = "${var.app.prefix}-${var.app.name}-${var.app.env}-vnet-${random_string.name.result}"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  address_space       = ["10.0.0.0/16"]
  
  # TODO: Use Private DNS
  # dns_servers         = ["10.0.0.4", "10.0.0.5"]
}

resource "azurerm_subnet" "main" {
  name                 = "${var.app.prefix}-${var.app.name}-${var.app.env}-main"
  resource_group_name  = azurerm_resource_group.main.name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_network_security_group" "main" {
  name                = "main"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name

  security_rule {
    name                       = "SSH"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

    security_rule {
    name                       = "HTTP"
    priority                   = 1002
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "Outbound-All"
    priority                   = 1002
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_network_interface_security_group_association" "example" {
  network_interface_id      = azurerm_network_interface.vm_nic.id
  network_security_group_id = azurerm_network_security_group.main.id
}

resource "azurerm_network_interface" "vm_nic" {
  name                = "${var.app.prefix}-${var.app.name}-${var.app.env}-vm-nic-${random_string.name.result}"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name

  ip_configuration {
    name                          = "${var.app.prefix}-${var.app.name}-${var.app.env}-vm-ip-config"
    subnet_id                     = azurerm_subnet.main.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.vm.id
  }
}

resource "azurerm_public_ip" "vm" {
  name                = "${var.app.prefix}-${var.app.name}-${var.app.env}-public-ip-${random_string.name.result}"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  allocation_method          = "Static"
  sku                 = "Standard"

  tags = {
    environment = var.app.env
  }
}

# resource "azurerm_nat_gateway" "vm_nat_gateway" {
#   name                = "${var.app.prefix}-${var.app.name}-${var.app.env}-nat-gateway-${random_string.name.result}"
#   location            = azurerm_resource_group.main.location
#   resource_group_name = azurerm_resource_group.main.name

#   # sku               = "Standard"
# }

# resource "azurerm_nat_gateway_public_ip_association" "vm_nat_gateway_public_ip" {
#   nat_gateway_id = azurerm_nat_gateway.vm_nat_gateway.id
#   public_ip_address_id = azurerm_public_ip.vm_public_ip.id
# }
