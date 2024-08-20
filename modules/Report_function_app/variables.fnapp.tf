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
variable "report_asp_sku_name" {
  type = string
}
variable "report_fnapp_name" {
  type = string
}
variable "reports_storage_account_name" {
  type = string
}
# tags values
variable "environment" {
  type = string
  description = "the environment you are using for this infrastructure"
}

variable "project_name" {
  type = string
  description = "name of the project for which these scripts are run"
}

variable "owners" {
  type = string
  description = "owners of the project for which these scripts are run"
}

variable "vendor" {
  type = string
  description = "vendor of the project for which these scripts are run"
}

variable "eng" {
    type = string
  description = "engineer for the project for which these scripts are run"
}

variable "deployment_type" {
  type = string
  description = "deployment type of the infrastructure- automated when these scripts are used. Manual when created manually"
}
variable "registry_name" {
  type = string
}
variable "repository_name" {
  type = string
}

variable "tag" {
  type = string
}
variable "registry_rg" {
  type = string
}