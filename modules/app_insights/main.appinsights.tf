resource "azurerm_application_insights" "ams_appins" {
  name                = "mysamptestingamsins"
  location            = var.location
  resource_group_name = var.resource_group_name
  application_type    = var.application_type
  tags = {
    Project = var.project_name
    Environment = var.environment
    Owner = var.owners
    Vendor = var.vendor
    Eng = var.eng
    Deployment_type = var.deployment_type
  }
}