locals {
  deploy_strg_account = var.deploy_strg_account
  deploy_strg_account1 = var.deploy_strg_account1
  deploy_key_vault = var.deploy_key_vault
  deploy_aks_ams = var.deploy_aks_ams
  deploy_redis_cache = var.deploy_redis_cache
  deploy_app_insights = var.deploy_app_insights
  deploy_fnapp = var.deploy_fnapp
  deploy_cosmos = var.deploy_cosmos
  deploy_report_fnapp = var.deploy_report_fnapp
  deploy_cosmoscont = var.deploy_cosmoscont
  deploy_application_gateway = var.deploy_application_gateway
  deploy_service_bus = var.deploy_service_bus
}
resource "azurerm_resource_group" "rg" {
  name     = "ams-${var.environment}"
  location = var.location
  tags = {
    environment = var.environment
    vendor = var.vendor
    project_name = var.project_name
    owners = var.owners
    eng = var.eng
    deployment_type = var.deployment_type
  }

}
data "azuread_group" "amsad" {
  display_name = "AMS-Group"
}
data "azurerm_client_config" "current" {}
resource "azurerm_role_assignment" "ra1" {
  scope                = azurerm_resource_group.rg.id
  role_definition_name = "Contributor"
  principal_id         = data.azuread_group.amsad.id
  depends_on = [azurerm_resource_group.rg]
}
resource "azurerm_role_assignment" "ra2" {
  scope                = azurerm_resource_group.rg.id
  role_definition_name = "Contributor"
  principal_id         = data.azurerm_client_config.current.object_id
  depends_on = [azurerm_resource_group.rg]
}

module "strg_account" {
  source                   = "./modules/storage_account"
  environment = var.environment
  vendor = var.vendor
  project_name = var.project_name
  owners = var.owners
  eng = var.eng
  deployment_type = var.deployment_type
  depends_on = [azurerm_resource_group.rg]
  count = local.deploy_strg_account == true ? 1 : 0
  
}

module "key_vault" {
  source              = "./modules/key_vault"
 
  ConnectionStringBasedSecrets = var.ConnectionStringBasedSecrets
 
  BaseUriBasedSecrets = var.BaseUriBasedSecrets
 
  deploy_aks_ams = var.deploy_aks_ams
  deploy_app_insights = var.deploy_app_insights
  deploy_cosmos = var.deploy_cosmos
#  deploy_event_grid = var.deploy_event_grid
  deploy_fnapp = var.deploy_fnapp
  deploy_key_vault = var.deploy_key_vault
  deploy_redis_cache = var.deploy_redis_cache
  deploy_strg_account = var.deploy_strg_account
  environment = var.environment
  vendor = var.vendor
  project_name = var.project_name
  owners = var.owners
  eng = var.eng
  deployment_type = var.deployment_type
  depends_on = [azurerm_resource_group.rg,module.app_insights,module.cosmos,module.redis_cache,module.aks_ams]
  count = local.deploy_key_vault == true ? 1 : 0
}

module "aks_ams" {
  source              = "./modules/AKS"

  environment = var.environment
  vendor = var.vendor
  project_name = var.project_name
  owners = var.owners
  eng = var.eng
  deployment_type = var.deployment_type
  depends_on = [azurerm_resource_group.rg]
  count = local.deploy_aks_ams == true ? 1 : 0
}
module "aks_vmss" {
  source              = "./modules/VMSS"
  resource_group_name = var.resource_group_name
  location = var.location
  kv_name = var.kv_name
  AKS_name = var.AKS_name

  environment         = var.environment
  depends_on = [azurerm_resource_group.rg,module.aks_ams,module.key_vault]
}
module "redis_cache" {
  source              = "./modules/redis_cache"

  environment = var.environment
  vendor = var.vendor
  project_name = var.project_name
  owners = var.owners
  eng = var.eng
  deployment_type = var.deployment_type
  depends_on = [azurerm_resource_group.rg]
  count = local.deploy_redis_cache == true ? 1 : 0
}

module "app_insights" {
  source              = "./modules/app_insights"
 
  environment = var.environment
  vendor = var.vendor
  project_name = var.project_name
  owners = var.owners
  eng = var.eng
  deployment_type = var.deployment_type
  depends_on = [azurerm_resource_group.rg]
  count = local.deploy_app_insights == true ? 1 : 0
}

module "fnapp" {
  source               = "./modules/function_app"
 
  registry_name = var.registry_name
  registry_rg  = var.registry_rg
  repository_name = var.repository_name
  tag = var.tag
 
  environment = var.environment
  vendor = var.vendor
  project_name = var.project_name
  owners = var.owners
  eng = var.eng
  deployment_type = var.deployment_type
  depends_on = [azurerm_resource_group.rg,module.strg_account]
  count = local.deploy_fnapp == true ? 1 : 0
}
module "report_fnapp" {
  source               = "./modules/Report_function_app"

  registry_name = var.registry_name
  registry_rg  = var.registry_rg
  repository_name = var.repository_name
  tag = var.tag
 
  environment = var.environment
  vendor = var.vendor
  project_name = var.project_name
  owners = var.owners
  eng = var.eng
  deployment_type = var.deployment_type
  depends_on = [azurerm_resource_group.rg,module.strg_account]
  count = local.deploy_report_fnapp == true ? 1 : 0
}
module "cosmos" {
  source              = "./modules/Cosmos_DB_lower"
 
  environment = var.environment
  vendor = var.vendor
  project_name = var.project_name
  owners = var.owners
  eng = var.eng
  deployment_type = var.deployment_type
  depends_on = [azurerm_resource_group.rg]
  count = local.deploy_cosmos == true ? 1 : 0
}

module "cosmos_cont" {
  source              = "./modules/Cosmos_Container_lower"


  environment = var.environment
  vendor = var.vendor
  project_name = var.project_name
  owners = var.owners
  eng = var.eng
  deployment_type = var.deployment_type
  depends_on = [azurerm_resource_group.rg,module.cosmos]
  count = local.deploy_cosmoscont == true ? 1 : 0
}


module "svcbus" {
  source = "./modules/ServiceBus"
 
  environment = var.environment
  vendor = var.vendor
  project_name = var.project_name
  owners = var.owners
  eng = var.eng
  deployment_type = var.deployment_type
  depends_on = [azurerm_resource_group.rg]
  count = local.deploy_service_bus == true ? 1 : 0
}