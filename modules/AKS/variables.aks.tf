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