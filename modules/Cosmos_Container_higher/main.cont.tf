data azurerm_cosmosdb_account cosmos {
   name = "cosmos-ams-${var.environment}"
   resource_group_name = "ams-${var.environment}"
}
data azurerm_cosmosdb_sql_database sqldb {
    name = "ams"
    resource_group_name = "ams-${var.environment}"
    account_name = data.azurerm_cosmosdb_account.cosmos.name
}
locals {
  cont1= jsondecode(file("${path.module}/${var.cont1}.json"))
  cont1_index = { 
    composite_indexes = {
    for item in local.cont1.compositeIndexes[0]: 
    item.path => item.order
    }
  included_paths = {
      for item in local.cont1.includedPaths:
      item.path => null
  }  
  excluded_paths = {
      for item in local.cont1.excludedPaths:
      item.path => null 
  }  
  }
}

# this needs to be added to different environments. There needs to be different main.tf for 
# each environment as the autoscale settings are different for each container
# in different environments.
resource "azurerm_cosmosdb_sql_container" "cont1" {
  name                  = "ams-users"
  resource_group_name   = data.azurerm_cosmosdb_account.cosmos.resource_group_name
  account_name          = data.azurerm_cosmosdb_account.cosmos.name
  database_name         = data.azurerm_cosmosdb_sql_database.sqldb.name
  partition_key_path    = "/sapcode"
  partition_key_version = 1

  autoscale_settings {
    max_throughput = var.cont_throughput
  }

 indexing_policy {
    dynamic "included_path" {
      for_each = local.cont1_index.included_paths
      content { 
        path = included_path.key
        }
    }
    dynamic "excluded_path" {
      for_each = local.cont1_index.excluded_paths
      content { 
        path = excluded_path.key
        }
    }
    composite_index {
      dynamic "index" {
      for_each = local.cont1_index.composite_indexes
      content {
        path   = index.key
        order  = index.value
      }
  }
}
}
}

resource "azurerm_cosmosdb_sql_container" "cont2" {
  name                  = "amslogs"
  resource_group_name   = data.azurerm_cosmosdb_account.cosmos.resource_group_name
  account_name          = data.azurerm_cosmosdb_account.cosmos.name
  database_name         = data.azurerm_cosmosdb_sql_database.sqldb.name
  partition_key_path    = "/key"
  partition_key_version = 1
  throughput            = var.cont_throughput

}

