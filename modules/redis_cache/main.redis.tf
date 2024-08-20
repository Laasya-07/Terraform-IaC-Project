data azurerm_resource_group rg {
  name = var.resource_group_name
}

resource "azurerm_redis_cache" "example" {
  name                = "redis-ams-${var.environment}"
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
  capacity            = var.redis_capacity
  family              = var.redis_family
  sku_name            = var.redis_sku_name
  enable_non_ssl_port = false
  minimum_tls_version = "1.2"

  redis_configuration {
  }
  tags = {
    Project = var.project_name
    Environment = var.environment
    Owner = var.owners
    Vendor = var.vendor
    Eng = var.eng
    Deployment_type = var.deployment_type
  }
}