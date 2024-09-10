resource "random_string" "acr_name" {
  length  = 6
  special = false
  upper   = false
}

resource "azurerm_container_registry" "main" {
  name                = "${var.app.prefix}${var.app.env}acr${random_string.acr_name.result}"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  sku                 = "Standard"
  
  # Enable the Admin user
  admin_enabled = true

  tags = {
    environment = var.app.env
  }
}

# Output the ACR login server name
output "acr_login_server" {
  value = azurerm_container_registry.main.login_server
}

# Output the admin username
output "acr_admin_username" {
  value = azurerm_container_registry.main.admin_username
}

# Output the admin password
output "acr_admin_password" {
  value     = azurerm_container_registry.main.admin_password
  sensitive = true
}