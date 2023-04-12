resource "azurerm_log_analytics_workspace" "main" {
  name                = "${var.app.prefix}-${var.app.stage}-workspace"
  location            = var.location
  resource_group_name = local.resource_group_name
  sku                 = "PerGB2018"
}

resource "azurerm_monitor_diagnostic_setting" "api" {
  name               = "${var.app.prefix}-${var.app.stage}-api-diag"
  target_resource_id = azurerm_linux_web_app.api.id
  log_analytics_workspace_id = azurerm_log_analytics_workspace.main.id

  log {
    category = "AppServiceHTTPLogs"
    enabled  = true

    retention_policy {
      enabled = true
      days    = 7
    }
  }

  metric {
    category = "AllMetrics"

    retention_policy {
      enabled = true
      days    = 7
    }
  }
}