data "azurerm_resource_group" "rg" {
  name     = "ams-${var.environment}"
}

resource "azurerm_storage_account" "strg_ams" {
  name                     = "strgac1ams${var.environment}"
  resource_group_name      = data.azurerm_resource_group.rg.name
  location                 = data.azurerm_resource_group.rg.location
  account_kind             = "StorageV2"
  account_tier             = "Standard"
  account_replication_type = "ZRS"
  is_hns_enabled = false
  blob_properties {
    versioning_enabled = true
  }
  tags = {
    Project = var.project_name
    Environment = var.environment
    Owner = var.owners
    Vendor = var.vendor
    Eng = var.eng
    Deployment_type = var.deployment_type
  }
}