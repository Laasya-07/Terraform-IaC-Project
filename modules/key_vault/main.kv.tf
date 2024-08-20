data "azurerm_client_config" "current" {}

data "azurerm_resource_group" "rg" {
  name = "ams-${var.environment}"
}

locals {
  deploy_strg_account = var.deploy_strg_account
  deploy_key_vault = var.deploy_key_vault
  deploy_aks_ams = var.deploy_aks_ams
  deploy_redis_cache = var.deploy_redis_cache
  deploy_app_insights = var.deploy_app_insights
  deploy_fnapp = var.deploy_fnapp
  deploy_cosmos = var.deploy_cosmos
}

resource "azurerm_key_vault" "nscsecrets" {
  name                       = "kvault-ams-${var.environment}"
  resource_group_name        = data.azurerm_resource_group.rg.name
  location                   = data.azurerm_resource_group.rg.location
  sku_name                   = "standard"
  tenant_id                  = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days = 7
  purge_protection_enabled   = false
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
    prevent_destroy = true
    ignore_changes = all
  }

}
data "azurerm_key_vault" "kv" {
  name                = "kvault-ams-${var.environment}"
  resource_group_name = data.azurerm_resource_group.rg.name
  depends_on = [azurerm_key_vault.nscsecrets,data.azurerm_resource_group.rg]
}


data "azurerm_application_insights" "appins" {
  name                = "amsappinsight${var.environment}"
  resource_group_name = "ams-${var.environment}"
  count = local.deploy_app_insights == true ? 1 : 0
}





resource "azurerm_key_vault_access_policy" "service_principal" { // This is for the Service Principal in the pipeline to be able to make changes to Key Vault. 
  key_vault_id        = azurerm_key_vault.nscsecrets.id
  tenant_id           = data.azurerm_client_config.current.tenant_id
  object_id           = data.azurerm_client_config.current.object_id
  secret_permissions  = ["Backup", "Delete", "Get", "List", "Purge", "Recover", "Restore", "Set", ]
  key_permissions     = ["Backup", "Create", "Decrypt", "Delete", "Encrypt", "Get", "Import", "List", "Purge", "Recover", "Restore", "Sign", "UnwrapKey", "Update", "Verify", "WrapKey", ]
  storage_permissions = ["Backup", "Delete", "DeleteSAS", "Get", "GetSAS", "List", "ListSAS", "Purge", "Recover", "RegenerateKey", "Restore", "Set", "SetSAS", "Update", ]
 
  lifecycle {
    #create_before_destroy = true
    prevent_destroy = true
    ignore_changes = all
  }
}



data "azurerm_kubernetes_cluster" "aks" {
  name                = "aks-ams-${var.environment}"
  resource_group_name = "ams-${var.environment}"
  
}
data "azurerm_resources" "ids" {
  type = "Microsoft.ManagedIdentity/userAssignedIdentities"
  resource_group_name = data.azurerm_kubernetes_cluster.aks.node_resource_group
  
}

data "azurerm_resources" "vmss" {
  type = "Microsoft.Compute/virtualMachineScaleSets"
  resource_group_name = data.azurerm_kubernetes_cluster.aks.node_resource_group
  depends_on = [ data.azurerm_kubernetes_cluster.aks ]
}

data "azurerm_virtual_machine_scale_set" "vmsss" {
  name                = data.azurerm_resources.vmss.resources[0].name
  resource_group_name = data.azurerm_kubernetes_cluster.aks.node_resource_group
}

data "azurerm_user_assigned_identity" "mi1" {
  name = data.azurerm_resources.ids.resources[0].name
  resource_group_name = data.azurerm_kubernetes_cluster.aks.node_resource_group

  
}
data "azurerm_user_assigned_identity" "mi2" {
  name = data.azurerm_resources.ids.resources[1].name
  resource_group_name = data.azurerm_kubernetes_cluster.aks.node_resource_group

 
}
data "azurerm_user_assigned_identity" "mi3" {
  name = data.azurerm_resources.ids.resources[2].name
  resource_group_name = data.azurerm_kubernetes_cluster.aks.node_resource_group

  
}
resource "azurerm_key_vault_access_policy" "mip1" { // This is for the Group in the Azure to be able to make changes to Key Vault. 
  key_vault_id        = azurerm_key_vault.nscsecrets.id
  tenant_id           = data.azurerm_client_config.current.tenant_id
  object_id           = data.azurerm_user_assigned_identity.mi1.principal_id
  secret_permissions  = ["Backup", "Delete", "Get", "List", "Purge", "Recover", "Restore", "Set", ]
  key_permissions     = ["Backup", "Create", "Decrypt", "Delete", "Encrypt", "Get", "Import", "List", "Purge", "Recover", "Restore", "Sign", "UnwrapKey", "Update", "Verify", "WrapKey", ]
  storage_permissions = ["Backup", "Delete", "DeleteSAS", "Get", "GetSAS", "List", "ListSAS", "Purge", "Recover", "RegenerateKey", "Restore", "Set", "SetSAS", "Update", ]
  lifecycle {
    create_before_destroy = true
    prevent_destroy = true
    ignore_changes = all
  }
  depends_on = [azurerm_key_vault.nscsecrets]
}

resource "azurerm_key_vault_access_policy" "mip2" { // This is for the Group in the Azure to be able to make changes to Key Vault. 
  key_vault_id        = azurerm_key_vault.nscsecrets.id
  tenant_id           = data.azurerm_client_config.current.tenant_id
  object_id           = data.azurerm_user_assigned_identity.mi2.principal_id
  secret_permissions  = ["Backup", "Delete", "Get", "List", "Purge", "Recover", "Restore", "Set", ]
  key_permissions     = ["Backup", "Create", "Decrypt", "Delete", "Encrypt", "Get", "Import", "List", "Purge", "Recover", "Restore", "Sign", "UnwrapKey", "Update", "Verify", "WrapKey", ]
  storage_permissions = ["Backup", "Delete", "DeleteSAS", "Get", "GetSAS", "List", "ListSAS", "Purge", "Recover", "RegenerateKey", "Restore", "Set", "SetSAS", "Update", ]
  lifecycle {
    create_before_destroy = true
    prevent_destroy = true
    ignore_changes = all
  }
  depends_on = [azurerm_key_vault.nscsecrets]
}

resource "azurerm_key_vault_access_policy" "mip3" { // This is for the Group in the Azure to be able to make changes to Key Vault. 
  key_vault_id        = azurerm_key_vault.nscsecrets.id
  tenant_id           = data.azurerm_client_config.current.tenant_id
  object_id           = data.azurerm_user_assigned_identity.mi3.principal_id
  secret_permissions  = ["Backup", "Delete", "Get", "List", "Purge", "Recover", "Restore", "Set", ]
  key_permissions     = ["Backup", "Create", "Decrypt", "Delete", "Encrypt", "Get", "Import", "List", "Purge", "Recover", "Restore", "Sign", "UnwrapKey", "Update", "Verify", "WrapKey", ]
  storage_permissions = ["Backup", "Delete", "DeleteSAS", "Get", "GetSAS", "List", "ListSAS", "Purge", "Recover", "RegenerateKey", "Restore", "Set", "SetSAS", "Update", ]
  lifecycle {
    create_before_destroy = true
      prevent_destroy = true
    ignore_changes = all
  }
  depends_on = [azurerm_key_vault.nscsecrets]
  
}
#resource "azurerm_key_vault_access_policy" "sip" { // This is for the Group in the Azure to be able to make changes to Key Vault. 
#  key_vault_id        = azurerm_key_vault.nscsecrets.id
#  tenant_id           = data.azurerm_client_config.current.tenant_id
#  object_id           = data.azurerm_virtual_machine_scale_set.vmsss.identity[0].principal_id
#  secret_permissions  = ["Backup", "Delete", "Get", "List", "Purge", "Recover", "Restore", "Set", ]
#  key_permissions     = ["Backup", "Create", "Decrypt", "Delete", "Encrypt", "Get", "Import", "List", "Purge", "Recover", "Restore", "Sign", "UnwrapKey", "Update", "Verify", "WrapKey", ]
#  storage_permissions = ["Backup", "Delete", "DeleteSAS", "Get", "GetSAS", "List", "ListSAS", "Purge", "Recover", "RegenerateKey", "Restore", "Set", "SetSAS", "Update", ]
#  depends_on = [azurerm_key_vault.nscsecrets,data.azurerm_virtual_machine_scale_set.vmsss]
  
#}
resource "azurerm_key_vault_secret" "secret1" {
  name         = "AppInsights--InstrumentationKey"
  value        = data.azurerm_application_insights.appins[count.index].instrumentation_key
  key_vault_id = azurerm_key_vault.nscsecrets.id
  count = local.deploy_app_insights == true ? 1 : 0
  lifecycle {
    create_before_destroy = true
    prevent_destroy = true
    ignore_changes = all
  }
  depends_on = [azurerm_key_vault.nscsecrets,azurerm_key_vault_access_policy.service_principal,data.azurerm_application_insights.appins]
}

resource "azurerm_key_vault_secret" "secret2" {
  name         = "AppInsights--ConnectionString"
  value        = data.azurerm_application_insights.appins[count.index].connection_string
  key_vault_id = azurerm_key_vault.nscsecrets.id
  count = local.deploy_app_insights == true ? 1 : 0
  lifecycle {
    create_before_destroy = true
    prevent_destroy = true
    ignore_changes = all
  }
  depends_on = [azurerm_key_vault.nscsecrets,azurerm_key_vault_access_policy.service_principal,data.azurerm_application_insights.appins]
}





resource "azurerm_key_vault_secret" "secret5" {
  name         = "CosmosDb--DatabaseName"
  value        = "ams"
  key_vault_id = azurerm_key_vault.nscsecrets.id
  count = local.deploy_cosmos == true ? 1 : 0
  depends_on = [azurerm_key_vault.nscsecrets,azurerm_key_vault_access_policy.service_principal]
   lifecycle {
    create_before_destroy = true
    prevent_destroy = true
    ignore_changes = all
  }
}




resource "azurerm_key_vault_secret" "secret7" {
  name         = "Redis--DefaultTimeSpan"
  value        =  86400
  key_vault_id = azurerm_key_vault.nscsecrets.id
  count = local.deploy_redis_cache == true ? 1 : 0
  depends_on = [azurerm_key_vault.nscsecrets,azurerm_key_vault_access_policy.service_principal]
   lifecycle {
    create_before_destroy = true
    prevent_destroy = true
    ignore_changes = all
  }
  #depends_on = [azurerm_key_vault.nscsecrets,data.azurerm_resource_group.rg,azurerm_key_vault_access_policy.service_principal,azurerm_key_vault_access_policy.group,azurerm_key_vault_access_policy.mi1,azurerm_key_vault_access_policy.mi2,azurerm_key_vault_access_policy.mi3]
}




resource "azurerm_key_vault_secret" "varSecret1" {
  for_each = var.ConnectionStringBasedSecrets
  name         = each.key
  value        = each.value
  key_vault_id = data.azurerm_key_vault.kv.id
   lifecycle {
    create_before_destroy = true
    prevent_destroy = true
    ignore_changes = all
  }
  depends_on = [azurerm_key_vault_access_policy.service_principal,azurerm_key_vault.nscsecrets]
}

resource "azurerm_key_vault_secret" "varSecret2" {
  for_each = var.BaseUriBasedSecrets
  name         = each.key
  value        = each.value
  key_vault_id = data.azurerm_key_vault.kv.id
   lifecycle {
    create_before_destroy = true
    prevent_destroy = true
    ignore_changes = all
  }
  depends_on = [azurerm_key_vault_access_policy.service_principal,azurerm_key_vault.nscsecrets]
}

