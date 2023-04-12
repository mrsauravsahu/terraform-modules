resource "azurerm_service_plan" "main" {
  name                = "${var.app.prefix}-${var.app.stage}-api"
  resource_group_name = local.resource_group_name
  location            = var.location
  os_type             = "Linux"
  sku_name            = "B1"
}

resource "azurerm_linux_web_app" "api" {
  name                = "${var.app.prefix}-${var.app.stage}-api"
  resource_group_name = local.resource_group_name
  location            = var.location
  service_plan_id     = azurerm_service_plan.main.id

  site_config {}
}
