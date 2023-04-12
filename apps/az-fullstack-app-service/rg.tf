locals {
  resource_group_name = coalesce(var.rg.overriden_name, "${var.app.prefix}-${var.app.stage}")
}

resource "azurerm_resource_group" "main" {
  name = local.resource_group_name
  location = var.location
  //https://developer.hashicorp.com/terraform/language/meta-arguments/lifecycle#prevent_destroy
}
