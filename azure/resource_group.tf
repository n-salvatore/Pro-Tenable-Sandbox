resource "azurerm_resource_group" "example" {
  name     = "tf-${var.environment}"
  location = var.location
}