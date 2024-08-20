data "azurerm_resource_group" "rg" {
  name     = "ams-${var.environment}"

}
resource "azurerm_storage_account" "strg_ams" {
  name                     = "strgacams${var.environment}"
  resource_group_name      = data.azurerm_resource_group.rg.name
  location                 = data.azurerm_resource_group.rg.location
  account_kind             = var.account_kind
  account_tier             = var.account_tier
  account_replication_type = var.account_replication_type
  is_hns_enabled = true
  
  tags = {
    Project = var.project_name
    Environment = var.environment
    Owner = var.owners
    Vendor = var.vendor
    Eng = var.eng
    Deployment_type = var.deployment_type
  }
}