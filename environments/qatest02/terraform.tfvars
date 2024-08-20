#count variable set for the resources to be created
deploy_strg_account  = true
deploy_strg_account1 = false

deploy_key_vault    = true
deploy_aks_ams      = true
deploy_redis_cache  = false
deploy_app_insights = false
deploy_fnapp        = true
deploy_report_fnapp = true
deploy_cosmos       = true
deploy_cosmoscont   = true
#deploy_event_grid = #{deploy_event_grid}#
deploy_application_gateway = false
deploy_service_bus         = true
resource_group_name        = ""
cont_throughput = 2000
location = "centralindia"
#Variables for tags
environment     = ""
project_name    = ""
owners          = ""
vendor          = ""
eng             = ""
deployment_type = ""

#variables for ad group
#group_name = "#{group_name}#"
cont1 = ""
#variables for key vault
ConnectionStringBasedSecrets = {
  "AzureBlobConnectionString" = "",
  "MySqlConnection"                                  = "",
  "ServiceBus"                                        = "",
  "SupermanRedisConfig"                               = ""
}

BaseUriBasedSecrets = {
  "BaseUri1"     = "https://foo.com/2",
  "BaseUri2"       = "https://foo.com/1"
}
client_id = ""
client_secret = ""
subscription_id = ""
tenant_id = ""
AKS_name  = ""
kv_name   = ""

repository_name = ""
tag             = ""
registry_name   = ""
registry_rg     = ""


kubernetes_version               = ""
sku_tier                         = ""
http_application_routing_enabled = true
nodepool_name                    = ""
min_count                        = 1
max_count                        = 8
key_vault_secrets_provider       = true
nodepool_vm_size                 = "Standard_DS2_v2"
identity_type                    = "SystemAssigned"
zones                            = ["1","2"]
temporary_name_for_rotation      = ""
nodepool_enable_auto_scaling     = true

redis_capacity = 2
redis_family   = "C"
redis_sku_name = "Standard"

workspace_sku     = "PerGB2018"
retention_in_days = 30
application_type  = "web"

asp_sku_name = "Y1"

report_fnapp_name             = ""
EventReportServiceUri         = ""
ServiceBusConnectionString    = ""
ReportTempStoragePath         = ""
ReportStorageConnectionString = ""
reports_storage_account_name  = ""
report_asp_sku_name           = "Y1"

svcbus_sku = "Basic"
enable_partitioning = false
max_size_in_megabytes = 1024
dead_lettering_on_message_expiration = true