data "azurerm_resource_group" "rg" {
  name = "ams-${var.environment}"
  }

resource "azurerm_storage_account" "strg_ams" {
  name                     = "strgams${var.environment}fn"
  resource_group_name      = data.azurerm_resource_group.rg.name
  location                 = data.azurerm_resource_group.rg.location
  account_kind             = "StorageV2"
  account_tier             = "Standard"
  account_replication_type = "ZRS"
  is_hns_enabled = false
  tags = {
    Project = var.project_name
    Environment = var.environment
    Owner = var.owners
    Vendor = var.vendor
    Eng = var.eng
    Deployment_type = var.deployment_type
  }
}

data "azurerm_container_registry" "cr" {
  name                = var.registry_name
  resource_group_name = var.registry_rg
}

resource "azurerm_service_plan" "asp" {
  name                = "aspams${var.environment}"
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = data.azurerm_resource_group.rg.location
  os_type             = "Windows"
  sku_name            = var.asp_sku_name
  tags = {
    Project = var.project_name
    Environment = var.environment
    Owner = var.owners
    Vendor = var.vendor
    Eng = var.eng
    Deployment_type = var.deployment_type
  }
}

resource "azurerm_linux_function_app" "fnapp" {
  name                = "fnapp-ams-${var.environment}"
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = data.azurerm_resource_group.rg.location
  storage_account_name       = azurerm_storage_account.strg_ams.name
  storage_account_access_key = azurerm_storage_account.strg_ams.primary_access_key
  service_plan_id            = azurerm_service_plan.asp.id
  app_settings = {

  }
 site_config {
     application_stack {
      dotnet_version = "6.0"
    }
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