
variable "virtual_network_name" {
    type = string
}
variable "address_space" {
    type = string
}
variable "subnet_name" {
    type = string
}
variable "address_prefixes" {
    type = string
}
variable "public_ip_name" {
    type = string
}
variable "pip_allocation_method" {
    type = string
}

variable "appgateway_name" {
    type = string
}

variable "appgw_sku_name" {
    type = string
}
variable "appgw_sku_tier" {
    type = string
}

variable "appgw_sku_capacity" {
    type = number
}

variable "gateway_ip_configuration" {
    type = string
}
variable environment {
    type = string
}