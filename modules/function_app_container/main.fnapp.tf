data "azurerm_resource_group" "rg" {
  name = "ams-${var.environment}"
  }
#"strgacams${var.environment}fnapp"
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
  os_type             = "Linux"
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
    DOCKER_REGISTRY_SERVER_URL               = "${data.azurerm_container_registry.cr.login_server}"
    DOCKER_REGISTRY_SERVER_USERNAME          = "${data.azurerm_container_registry.cr.admin_username}"
    DOCKER_REGISTRY_SERVER_PASSWORD          = "${data.azurerm_container_registry.cr.admin_password}"
    DOCKER_CUSTOM_IMAGE_NAME                 = "${data.azurerm_container_registry.cr.login_server}/${var.repository_name}:${var.tag}"
    WEBSITE_CONTENTAZUREFILECONNECTIONSTRING = "${azurerm_storage_account.strg_ams.primary_connection_string}"
    WEBSITE_CONTENTSHARE                     = "${azurerm_storage_account.strg_ams.name}"
    #FUNCTIONS_WORKER_RUNTIME = "custom"
  }
  site_config {
    #always_on        = true
    #linux_fx_version = "DOCKER|${data.azurerm_container_registry.cr.login_server}/nginx:latest"
    application_stack {
      #use_custom_runtime = true
      docker {
          image_name = "var.repository_name"
          registry_url = "${data.azurerm_container_registry.cr.login_server}"
          image_tag = var.tag
      }
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