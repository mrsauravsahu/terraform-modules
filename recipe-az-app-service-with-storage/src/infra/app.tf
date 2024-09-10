resource "random_string" "name" {
  length           = 6
  special          = false
  upper=false
}

# Create an App Service that runs NGINX in a Linux container
resource "azurerm_linux_web_app" "main" {
  name                = "${var.app.prefix}-${var.app.name}-${var.app.env}-app-${random_string.name.result}"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  service_plan_id     = azurerm_service_plan.main.id

  site_config {
    always_on = true

    application_stack {
      docker_image_name = "nginx"
      docker_registry_url ="https://docker.io"
    }
  }

  app_settings = {
    "WEBSITES_ENABLE_APP_SERVICE_STORAGE" = "false"  # Disable persistent storage
  }

  identity {
    type = "SystemAssigned"
  }
}

resource "azurerm_storage_account" "main" {
  name                     = "${var.app.prefix}${var.app.name}${var.app.env}"
  resource_group_name      = azurerm_resource_group.main.name
  location                 = azurerm_resource_group.main.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_service_plan" "main" {
  name                = "${var.app.prefix}-${var.app.name}-${var.app.env}-func-app-plan"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  os_type = "Linux"
  sku_name = "P0v3"
}
