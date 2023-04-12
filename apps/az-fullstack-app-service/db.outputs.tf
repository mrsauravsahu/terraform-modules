output "db" {
  value = {
    password = azurerm_postgresql_flexible_server.main.administrator_password
  }
  sensitive = true
}
