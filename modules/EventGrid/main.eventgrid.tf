data "azurerm_resource_group" "example" {
  name     = "ams-${var.environment}"
 
}

resource "azurerm_eventgrid_topic" "example" {
  name                = "eventgrid-ams-${var.environment}"
  location            = data.azurerm_resource_group.example.location
  resource_group_name = data.azurerm_resource_group.example.name

  tags = {
    Project = var.project_name
    Environment = var.environment
    Owner = var.owners
    Vendor = var.vendor
    Eng = var.eng
    Deployment_type = var.deployment_type
  }
  depends_on = [data.azurerm_resource_group.rg]
}