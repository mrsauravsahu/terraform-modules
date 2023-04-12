resource "random_password" "password" {
  length  = 24
  special = true
}

resource "azurerm_postgresql_flexible_server" "main" {
  name                = "${var.app.prefix}-${var.app.stage}-psql"
  resource_group_name = local.resource_group_name
  location            = var.location
  version             = "14"
  administrator_login = "admin_user"
  administrator_password = random_password.password.result
  storage_mb          = 32768
  sku_name            = "GP_Standard_D2s_v3"
  zone                = "1"
}

resource "azurerm_postgresql_flexible_server_database" "main" {
  name      = "${var.app.prefix}-${var.app.stage}-db"
  server_id = azurerm_postgresql_flexible_server.main.id
}
