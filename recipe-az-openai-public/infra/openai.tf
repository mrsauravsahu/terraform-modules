module "openai" {
  source              = "Azure/openai/azurerm"
  version             = "0.1.3"
  resource_group_name           = azurerm_resource_group.main.name
  location                      = azurerm_resource_group.main.location
  public_network_access_enabled = true
  deployment = {
    "gpt-35-turbo" = {
      name          = "gpt-35-turbo"
      model_format  = "OpenAI"
      model_name    = "gpt-35-turbo"
      model_version = "0301"
      scale_type    = "Standard"
    },
  }
  depends_on = [
    azurerm_resource_group.main
  ]
}
