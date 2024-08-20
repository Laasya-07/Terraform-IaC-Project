data "azurerm_resource_group" "rg" {
  name = "ams-${var.environment}"
}
resource "azurerm_redis_enterprise_cluster" "example" {
  name                = "redis-ams-${var.environment}"
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = data.azurerm_resource_group.rg.location

  sku_name = "Standard-2"
  tags = {
    Project = var.project_name
    Environment = var.environment
    Owner = var.owners
    Vendor = var.vendor
    Eng = var.eng
    Deployment_type = var.deployment_type
  }
}