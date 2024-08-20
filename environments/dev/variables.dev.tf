#variable "subscription_id" {
#  default = "#{subscription_id}#"
#}

variable "client_id" {
  type = string
}
variable "subscription_id" {
  type = string
}
variable "cont_throughput" {
  type = string
}
variable "cont1" {
  type = string
}
variable "client_secret" {
  type = string
}
variable "kubernetes_version" {
  type = string
}
variable "sku_tier" {
  type = string
}
variable "http_application_routing_enabled" {
  type = bool
}
variable "nodepool_name" {
  type = string
}
variable "nodepool_vm_size" {
  type = string
}
variable "nodepool_enable_auto_scaling" {
  type = bool
}
variable "min_count" {
  type = number
}
variable "max_count" {
  type = number
}
variable "temporary_name_for_rotation" {
  type = string
}
variable "identity_type" {
  type = string
}
variable "key_vault_secrets_provider" {
  type = bool
}
variable "zones" {
  type = list(string)

}
variable "report_asp_sku_name" {
  type = string
}
variable "report_fnapp_name" {
  type = string
}
variable "EventReportServiceUri" {
  type = string
}
variable "ReportStorageConnectionString" {
  type = string
}
variable "ReportTempStoragePath" {
  type = string
}
variable "ServiceBusConnectionString" {
  type = string
}
variable "asp_sku_name" {
  type = string
}
variable "reports_storage_account_name" {
  type = string
}

variable "workspace_sku" {
  type = string
}
variable "retention_in_days" {
  type = number
}
variable "application_type" {
  type = string
}
variable "redis_capacity" {
  type = number
}
variable "redis_family" {
  type = string
}
variable "redis_sku_name" {
  type = string
}
variable "deploy_strg_account" {
  type = bool
}
variable "deploy_strg_account1" {
  type = bool
}

variable "deploy_key_vault" {
  type = bool
}

variable "deploy_aks_ams" {
  type = bool
}

variable "deploy_redis_cache" {
  type = bool
}

variable "deploy_app_insights" {
  type = bool
}
variable "deploy_fnapp" {
  type = bool
}
variable "deploy_report_fnapp" {
  type = bool
}
variable "deploy_cosmos" {
  type = bool
}
variable "deploy_cosmoscont" {
  type = bool
}
#variable "deploy_event_grid" {
#  type = bool
#}
variable "deploy_application_gateway" {
  type = bool
}
variable "deploy_service_bus" {
  type = bool
}
variable "tenant_id" {
  type        = string
  description = "Directory ID where the resources are deployed"
}
variable "resource_group_name" {
  type = string
}

variable "kv_name" {
  type = string
}
variable "ConnectionStringBasedSecrets" {
  type = map(string)
}
variable "BaseUriBasedSecrets" {
  type = map(string)
}


variable "environment" {
  type        = string
  description = "the environment you are using for this infrastructure"
}

variable "project_name" {
  type        = string
  description = "name of the project for which these scripts are run"
}

variable "owners" {
  type        = string
  description = "owners of the project for which these scripts are run"
}

variable "vendor" {
  type        = string
  description = "vendor of the project for which these scripts are run"
}

variable "eng" {
  type        = string
  description = "engineer for the project for which these scripts are run"
}
variable "AKS_name" {
  type = string
}
variable "deployment_type" {
  type        = string
  description = "deployment type of the infrastructure- automated when these scripts are used. Manual when created manually"
}

variable "location" {
  type = string
}
variable "repository_name" {
  type = string
}
variable "registry_name" {
  type = string
}
variable "tag" {
  type = string
}
variable "registry_rg" {
  type = string
}

variable "svcbus_sku" {
  type = string
}
variable "enable_partitioning" {
  type = bool
}
variable "max_size_in_megabytes" {
  type = number
}
variable "dead_lettering_on_message_expiration" {
  type = bool
}



