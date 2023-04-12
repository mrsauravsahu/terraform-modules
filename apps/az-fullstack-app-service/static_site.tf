resource "azurerm_static_site" "fe" {
  name                = "${var.app.prefix}-${var.app.stage}-fe"
  resource_group_name = local.resource_group_name
  location            = var.location
}
