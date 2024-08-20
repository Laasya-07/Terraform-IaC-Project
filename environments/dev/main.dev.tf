
resource "azurerm_resource_group" "rg" {
  name     = "ams-${var.environment}"
  location = var.location
  tags = {
    environment     = var.environment
    vendor          = var.vendor
    project_name    = var.project_name
    owners          = var.owners
    eng             = var.eng
    deployment_type = var.deployment_type
  }

}
module "app_insights" {
  source            = "../../modules/app_insights"
  resource_group_name = var.resource_group_name
  location = var.location
  retention_in_days = var.retention_in_days
  application_type  = var.application_type
  environment       = var.environment
  vendor            = var.vendor
  project_name      = var.project_name
  owners            = var.owners
  eng               = var.eng
  deployment_type   = var.deployment_type
  depends_on        = [azurerm_resource_group.rg]
}

module "strg_account" {
  source          = "../../modules/storage_account"
  environment     = var.environment
  vendor          = var.vendor
  project_name    = var.project_name
  owners          = var.owners
  eng             = var.eng
  deployment_type = var.deployment_type
  depends_on      = [azurerm_resource_group.rg]
 

}

module "key_vault" {
  source = "../../modules/key_vault"

  ConnectionStringBasedSecrets = var.ConnectionStringBasedSecrets

  BaseUriBasedSecrets = var.BaseUriBasedSecrets

  deploy_aks_ams      = var.deploy_aks_ams
  deploy_app_insights = var.deploy_app_insights
  deploy_cosmos       = var.deploy_cosmos
  deploy_fnapp        = var.deploy_fnapp
  deploy_key_vault    = var.deploy_key_vault
  deploy_redis_cache  = var.deploy_redis_cache
  deploy_strg_account = var.deploy_strg_account
  environment         = var.environment
  vendor              = var.vendor
  project_name        = var.project_name
  owners              = var.owners
  eng                 = var.eng
  deployment_type     = var.deployment_type
  depends_on          = [azurerm_resource_group.rg, module.aks_ams]
  
}

module "aks_ams" {
  source                           = "../../modules/AKS"
  sku_tier                         = var.sku_tier
  kubernetes_version               = var.kubernetes_version
  max_count                        = var.max_count
  min_count                        = var.min_count
  key_vault_secrets_provider       = var.key_vault_secrets_provider
  nodepool_name                    = var.nodepool_name
  nodepool_vm_size                 = var.nodepool_vm_size
  http_application_routing_enabled = var.http_application_routing_enabled
  identity_type                    = var.identity_type
  temporary_name_for_rotation      = var.temporary_name_for_rotation
  nodepool_enable_auto_scaling     = var.nodepool_enable_auto_scaling
  zones                            = var.zones
  environment                      = var.environment
  vendor                           = var.vendor
  project_name                     = var.project_name
  owners                           = var.owners
  eng                              = var.eng
  deployment_type                  = var.deployment_type
  depends_on                       = [azurerm_resource_group.rg]
}
module "aks_vmss" {
  source              = "../../modules/VMSS"
  client_id = var.client_id
  client_secret = var.client_secret
  tenant_id = var.tenant_id
  subscription_id = var.subscription_id
  resource_group_name = var.resource_group_name
  location            = var.location
  kv_name             = var.kv_name
  AKS_name            = var.AKS_name
  environment         = var.environment
  depends_on          = [module.aks_ams, module.key_vault]
}



# module "fnapp" {
#   source          = "../../modules/function_app_container"
#   asp_sku_name    = var.asp_sku_name
#   registry_name   = var.registry_name
#   registry_rg     = var.registry_rg
#   repository_name = var.repository_name
#   tag             = var.tag

#   environment     = var.environment
#   vendor          = var.vendor
#   project_name    = var.project_name
#   owners          = var.owners
#   eng             = var.eng
#   deployment_type = var.deployment_type
#   depends_on      = [azurerm_resource_group.rg, module.strg_account]

# }
# module "report_fnapp" {
#   source                        = "../../modules/Report_function_app"
#   report_fnapp_name             = var.report_fnapp_name
#   EventReportServiceUri         = var.EventReportServiceUri
#   ServiceBusConnectionString    = var.ServiceBusConnectionString
#   ReportTempStoragePath         = var.ReportTempStoragePath
#   ReportStorageConnectionString = var.ReportStorageConnectionString
#   registry_name                 = var.registry_name
#   registry_rg                   = var.registry_rg
#   repository_name               = var.repository_name
#   tag                           = var.tag
#   reports_storage_account_name  = var.reports_storage_account_name
#   report_asp_sku_name           = var.report_asp_sku_name
#   environment                   = var.environment
#   vendor                        = var.vendor
#   project_name                  = var.project_name
#   owners                        = var.owners
#   eng                           = var.eng
#   deployment_type               = var.deployment_type
#   depends_on                    = [azurerm_resource_group.rg, module.strg_account]

# }
module "cosmos" {
  source          = "../../modules/Cosmos_DB_higher"
  location = var.location
  resource_group_name = var.resource_group_name
  environment     = var.environment
  vendor          = var.vendor
  project_name    = var.project_name
  owners          = var.owners
  eng             = var.eng
  deployment_type = var.deployment_type
  depends_on      = [azurerm_resource_group.rg]

}

module "cosmos_cont" {
  source = "../../modules/Cosmos_Container_higher"
  cont_throughput = var.cont_throughput
  cont1 = var.cont1
  environment     = var.environment
  vendor          = var.vendor
  project_name    = var.project_name
  owners          = var.owners
  eng             = var.eng
  deployment_type = var.deployment_type
  depends_on      = [azurerm_resource_group.rg, module.cosmos]

}


