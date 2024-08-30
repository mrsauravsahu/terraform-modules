resource "random_string" "func_name" {
  length           = 6
  special          = false
  upper=false
}

resource "azurerm_linux_function_app" "main" {
  name                      = "${var.app.prefix}-${var.app.name}-${var.app.env}-func-app-${random_string.func_name.result}"
  location                  = azurerm_resource_group.main.location
  resource_group_name       = azurerm_resource_group.main.name
  service_plan_id       = azurerm_service_plan.main.id
  storage_account_name      = azurerm_storage_account.main.name
  storage_account_access_key = azurerm_storage_account.main.primary_access_key
  app_settings = {
    "FUNCTIONS_WORKER_RUNTIME" = "node"
  }

  site_config {
    always_on = true

    application_stack {
      node_version = 18
    }
  }
}

resource "azurerm_storage_account" "main" {
  name                     = "${var.app.prefix}${var.app.name}${var.app.env}funcstorage"
  resource_group_name      = azurerm_resource_group.main.name
  location                 = azurerm_resource_group.main.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_service_plan" "main" {
  name                = "${var.app.prefix}-${var.app.name}-${var.app.env}-func-app-plan"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  # kind                = "FunctionApp"
  os_type = "Linux"
  # reserved            = true

  sku_name = "S1"
}
