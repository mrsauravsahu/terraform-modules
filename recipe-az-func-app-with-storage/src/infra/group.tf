resource "azurerm_resource_group" "main" {
  name     = var.app.name
  location = "East US"
}
