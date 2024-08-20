
variable "deploy_strg_account" {
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
variable "deploy_cosmos" {
  type = bool
}


variable "ConnectionStringBasedSecrets" {
  type = map(string)
}
variable "BaseUriBasedSecrets" {
  type = map(string)
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