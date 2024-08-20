data "azurerm_subscription" "primary" {}

data "azurerm_client_config" "config" {}
# resource group data source
data "azurerm_resource_group" "rg" {
  name = "ams-${var.environment}"
}

resource "azurerm_kubernetes_cluster" "aks" {
  name                = "aks-ams-${var.environment}"
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
  dns_prefix          = "aks-ams-${var.environment}dns"
  kubernetes_version  = var.kubernetes_version #1.26.6 is no longer supported
  sku_tier = var.sku_tier
  http_application_routing_enabled = var.http_application_routing_enabled


  default_node_pool {
    name                = var.nodepool_name
    vm_size             = var.nodepool_vm_size
    enable_auto_scaling = var.nodepool_enable_auto_scaling
    min_count           = var.min_count
    max_count           = var.max_count
    zones               = var.zones
    temporary_name_for_rotation = var.temporary_name_for_rotation

  }

  identity {
    type = var.identity_type
  }

  key_vault_secrets_provider {
    secret_rotation_enabled = var.key_vault_secrets_provider
  }
  tags = {
    Project = var.project_name
    Environment = var.environment
    Owner = var.owners
    Vendor = var.vendor
    Eng = var.eng
    Deployment_type = var.deployment_type
  }
  lifecycle {
    create_before_destroy = true
  }
  depends_on = [data.azurerm_resource_group.rg]
}

data "azurerm_kubernetes_cluster" "aks" {
  name                = azurerm_kubernetes_cluster.aks.name
  resource_group_name = data.azurerm_resource_group.rg.name
  depends_on = [azurerm_kubernetes_cluster.aks]

}