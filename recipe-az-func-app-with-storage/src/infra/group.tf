resource "azurerm_resource_group" "main" {
  name     = "${var.app.prefix}-${var.app.name}-${var.app.env}"
  location = var.app.location_primary
}
