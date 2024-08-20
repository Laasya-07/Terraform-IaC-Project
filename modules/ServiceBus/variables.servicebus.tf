# tags values
variable "environment" {
  type = string
  description = "the environment you are using for this infrastructure"
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