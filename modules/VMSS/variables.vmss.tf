variable "resource_group_name" {
  type        = string
  description = "Name of the resource group"
}

variable "location" {
  type        = string
  description = "location of the resource group"
}

variable "AKS_name" {
  type = string
  description = "name of aks cluster"
}
variable "subscription_id" {
  type = string
}
variable "client_id" {
  type = string
}
variable "client_secret" {
  type = string
}
variable "tenant_id" {
  type = string
}
variable "kv_name" {
  type = string
}

variable "environment" {
  type = string
  description = "the environment you are using for this infrastructure"
}