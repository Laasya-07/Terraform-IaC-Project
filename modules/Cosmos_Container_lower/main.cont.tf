data azurerm_cosmosdb_account cosmos {
   name = var.cosmosdb_account_name
   resource_group_name = var.resource_group_name
}
data azurerm_cosmosdb_sql_database sqldb {
    name = "ams"
    resource_group_name = var.resource_group_name
    account_name = data.azurerm_cosmosdb_account.cosmos.name
}
locals {
  cont1= jsondecode(file("${path.module}/ams-users.json"))
  cont1_index = { 
    composite_indexes = can(local.cont1.compositeIndexes) ? {
      for item in local.cont1.compositeIndexes[0] : 
      item.path => item.order
    } : {}
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
locals {
  cont2= jsondecode(file("${path.module}/amslogs.json"))
  cont2_index = { 
    composite_indexes = can(local.cont2.compositeIndexes) ? {
      for item in local.cont2.compositeIndexes[0] : 
      item.path => item.order
    } : {}
  included_paths = {
      for item in local.cont2.includedPaths:
      item.path => null
  }  
  excluded_paths = {
      for item in local.cont2.excludedPaths:
      item.path => null 
  }  
  }
}
locals {
  cont3= jsondecode(file("${path.module}/events.json"))
  cont3_index = { 
    composite_indexes = can(local.cont3.compositeIndexes) ? {
      for item in local.cont3.compositeIndexes[0] : 
      item.path => item.order
    } : {}
  included_paths = {
      for item in local.cont3.includedPaths:
      item.path => null
  }  
  excluded_paths = {
      for item in local.cont3.excludedPaths:
      item.path => null 
  }  
  }
}
locals {
  cont4= jsondecode(file("${path.module}/hcp.json"))
  cont4_index = { 
    composite_indexes = can(local.cont4.compositeIndexes) ? {
      for item in local.cont4.compositeIndexes[0] : 
      item.path => item.order
    } : {}
  included_paths = {
      for item in local.cont4.includedPaths:
      item.path => null
  }  
  excluded_paths = {
      for item in local.cont4.excludedPaths:
      item.path => null 
  }  
  }
}
locals {
  cont5= jsondecode(file("${path.module}/masters.json"))
  cont5_index = { 
    composite_indexes = can(local.cont5.compositeIndexes) ? {
      for item in local.cont5.compositeIndexes[0] : 
      item.path => item.order
    } : {}
  included_paths = {
      for item in local.cont5.includedPaths:
      item.path => null
  }  
  excluded_paths = {
      for item in local.cont5.excludedPaths:
      item.path => null 
  }  
  }
}
locals {
  cont6= jsondecode(file("${path.module}/notifications.json"))
  cont6_index = { 
    composite_indexes = can(local.cont6.compositeIndexes) ? {
      for item in local.cont6.compositeIndexes[0] : 
      item.path => item.order
    } : {}
  included_paths = {
      for item in local.cont6.includedPaths:
      item.path => null
  }  
  excluded_paths = {
      for item in local.cont6.excludedPaths:
      item.path => null 
  }  
  }
}
locals {
  cont7= jsondecode(file("${path.module}/roles.json"))
  cont7_index = { 
    composite_indexes = can(local.cont7.compositeIndexes) ? {
      for item in local.cont7.compositeIndexes[0] : 
      item.path => item.order
    } : {}
  included_paths = {
      for item in local.cont7.includedPaths:
      item.path => null
  }  
  excluded_paths = {
      for item in local.cont7.excludedPaths:
      item.path => null 
  }  
  }
}
locals {
  cont8= jsondecode(file("${path.module}/topic-logs.json"))
  cont8_index = { 
    composite_indexes = can(local.cont8.compositeIndexes) ? {
      for item in local.cont8.compositeIndexes[0] : 
      item.path => item.order
    } : {}
  included_paths = {
      for item in local.cont8.includedPaths:
      item.path => null
  }  
  excluded_paths = {
      for item in local.cont8.excludedPaths:
      item.path => null 
  }  
  }
}
locals {
  cont9= jsondecode(file("${path.module}/topics.json"))
  cont9_index = { 
    composite_indexes = can(local.cont9.compositeIndexes) ? {
      for item in local.cont9.compositeIndexes[0] : 
      item.path => item.order
    } : {}
  included_paths = {
      for item in local.cont9.includedPaths:
      item.path => null
  }  
  excluded_paths = {
      for item in local.cont9.excludedPaths:
      item.path => null 
  }  
  }
}
locals {
  cont10= jsondecode(file("${path.module}/sync-info.json"))
  cont10_index = { 
    composite_indexes = can(local.cont10.compositeIndexes) ? {
      for item in local.cont10.compositeIndexes[0] : 
      item.path => item.order
    } : {}
  included_paths = {
      for item in local.cont10.includedPaths:
      item.path => null
  }  
  excluded_paths = {
      for item in local.cont10.excludedPaths:
      item.path => null 
  }  
  }
}
locals {
  cont11= jsondecode(file("${path.module}/events-summary.json"))
  cont11_index = { 
    composite_indexes = can(local.cont11.compositeIndexes) ? {
      for item in local.cont11.compositeIndexes[0] : 
      item.path => item.order
    } : {}
  included_paths = {
      for item in local.cont11.includedPaths:
      item.path => null
  }  
  excluded_paths = {
      for item in local.cont11.excludedPaths:
      item.path => null 
  }  
  }
}
resource "azurerm_cosmosdb_sql_container" "cont1" {
  name                  = "ams-users"
  resource_group_name   = data.azurerm_cosmosdb_account.cosmos.resource_group_name
  account_name          = data.azurerm_cosmosdb_account.cosmos.name
  database_name         = data.azurerm_cosmosdb_sql_database.sqldb.name
  partition_key_path    = "/sapcode"
  partition_key_version = 1


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
    dynamic "composite_index" {
      for_each = can(local.cont1.compositeIndexes[0]) ? [1] : []
      content{
        dynamic "index" {
        for_each = local.cont1_index.composite_indexes
        content {
          path  = index.key
          order = index.value
      }
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
  indexing_policy {
    dynamic "included_path" {
      for_each = local.cont2_index.included_paths
      content { 
        path = included_path.key
        }
    }
    dynamic "excluded_path" {
      for_each = local.cont2_index.excluded_paths
      content { 
        path = excluded_path.key
        }
    }
    dynamic "composite_index" {
      for_each = can(local.cont2.compositeIndexes[0]) ? [1] : []
      content{
        dynamic "index" {
        for_each = local.cont2_index.composite_indexes
        content {
          path  = index.key
          order = index.value
      }
      }
      }
      
      
    }
}

}
resource "azurerm_cosmosdb_sql_container" "cont3" {
  name                  = "events"
  resource_group_name   = data.azurerm_cosmosdb_account.cosmos.resource_group_name
  account_name          = data.azurerm_cosmosdb_account.cosmos.name
  database_name         = data.azurerm_cosmosdb_sql_database.sqldb.name
  partition_key_path    = "/charterId"
  partition_key_version = 1


   indexing_policy {
    dynamic "included_path" {
      for_each = local.cont3_index.included_paths
      content { 
        path = included_path.key
        }
    }
    dynamic "excluded_path" {
      for_each = local.cont3_index.excluded_paths
      content { 
        path = excluded_path.key
        }
    }
    dynamic "composite_index" {
      for_each = can(local.cont3.compositeIndexes[0]) ? [1] : []
      content{
        dynamic "index" {
        for_each = local.cont3_index.composite_indexes
        content {
          path  = index.key
          order = index.value
      }
      }
      }
      
      
    }
}
}
  


resource "azurerm_cosmosdb_sql_container" "cont4" {
  name                  = "hcp"
  resource_group_name   = data.azurerm_cosmosdb_account.cosmos.resource_group_name
  account_name          = data.azurerm_cosmosdb_account.cosmos.name
  database_name         = data.azurerm_cosmosdb_sql_database.sqldb.name
  partition_key_path    = "/divisionId"
  partition_key_version = 1
  indexing_policy {
    dynamic "included_path" {
      for_each = local.cont4_index.included_paths
      content { 
        path = included_path.key
        }
    }
    dynamic "excluded_path" {
      for_each = local.cont4_index.excluded_paths
      content { 
        path = excluded_path.key
        }
    }
    dynamic "composite_index" {
      for_each = can(local.cont4.compositeIndexes[0]) ? [1] : []
      content{
        dynamic "index" {
        for_each = local.cont4_index.composite_indexes
        content {
          path  = index.key
          order = index.value
      }
      }
      }
      
      
    }
}
}



resource "azurerm_cosmosdb_sql_container" "cont5" {
  name                  = "masters"
  resource_group_name   = data.azurerm_cosmosdb_account.cosmos.resource_group_name
  account_name          = data.azurerm_cosmosdb_account.cosmos.name
  database_name         = data.azurerm_cosmosdb_sql_database.sqldb.name
  partition_key_path    = "/key"
  partition_key_version = 1
  indexing_policy {
    dynamic "included_path" {
      for_each = local.cont5_index.included_paths
      content { 
        path = included_path.key
        }
    }
    dynamic "excluded_path" {
      for_each = local.cont5_index.excluded_paths
      content { 
        path = excluded_path.key
        }
    }
    dynamic "composite_index" {
      for_each = can(local.cont5.compositeIndexes[0]) ? [1] : []
      content{
        dynamic "index" {
        for_each = local.cont5_index.composite_indexes
        content {
          path  = index.key
          order = index.value
      }
      }
      }
      
      
    }
}

}

resource "azurerm_cosmosdb_sql_container" "cont6" {
  name                  = "notifications"
  resource_group_name   = data.azurerm_cosmosdb_account.cosmos.resource_group_name
  account_name          = data.azurerm_cosmosdb_account.cosmos.name
  database_name         = data.azurerm_cosmosdb_sql_database.sqldb.name
  partition_key_path    = "/sapcode"
  partition_key_version = 1
   indexing_policy {
    dynamic "included_path" {
      for_each = local.cont6_index.included_paths
      content { 
        path = included_path.key
        }
    }
    dynamic "excluded_path" {
      for_each = local.cont6_index.excluded_paths
      content { 
        path = excluded_path.key
        }
    }
    dynamic "composite_index" {
      for_each = can(local.cont6.compositeIndexes[0]) ? [1] : []
      content{
        dynamic "index" {
        for_each = local.cont6_index.composite_indexes
        content {
          path  = index.key
          order = index.value
      }
      }
      }
      
      
    }
}
}

resource "azurerm_cosmosdb_sql_container" "cont7" {
  name                  = "roles"
  resource_group_name   = data.azurerm_cosmosdb_account.cosmos.resource_group_name
  account_name          = data.azurerm_cosmosdb_account.cosmos.name
  database_name         = data.azurerm_cosmosdb_sql_database.sqldb.name
  partition_key_path    = "/DivisionId"
  partition_key_version = 1
     indexing_policy {
    dynamic "included_path" {
      for_each = local.cont7_index.included_paths
      content { 
        path = included_path.key
        }
    }
    dynamic "excluded_path" {
      for_each = local.cont7_index.excluded_paths
      content { 
        path = excluded_path.key
        }
    }
    dynamic "composite_index" {
      for_each = can(local.cont7.compositeIndexes[0]) ? [1] : []
      content{
        dynamic "index" {
        for_each = local.cont7_index.composite_indexes
        content {
          path  = index.key
          order = index.value
      }
      }
      }
      
      
    }
}
}
resource "azurerm_cosmosdb_sql_container" "cont8" {
  name                  = "topic-logs"
  resource_group_name   = data.azurerm_cosmosdb_account.cosmos.resource_group_name
  account_name          = data.azurerm_cosmosdb_account.cosmos.name
  database_name         = data.azurerm_cosmosdb_sql_database.sqldb.name
  partition_key_path    = "/topicId"
  partition_key_version = 1
  indexing_policy {
    dynamic "included_path" {
      for_each = local.cont8_index.included_paths
      content { 
        path = included_path.key
        }
    }
    dynamic "excluded_path" {
      for_each = local.cont8_index.excluded_paths
      content { 
        path = excluded_path.key
        }
    }
    dynamic "composite_index" {
      for_each = can(local.cont8.compositeIndexes[0]) ? [1] : []
      content{
        dynamic "index" {
        for_each = local.cont8_index.composite_indexes
        content {
          path  = index.key
          order = index.value
      }
      }
      }
      
      
    }
}
}

resource "azurerm_cosmosdb_sql_container" "cont9" {
  name                  = "topics"
  resource_group_name   = data.azurerm_cosmosdb_account.cosmos.resource_group_name
  account_name          = data.azurerm_cosmosdb_account.cosmos.name
  database_name         = data.azurerm_cosmosdb_sql_database.sqldb.name
  partition_key_path    = "/charterId"
  partition_key_version = 1
    indexing_policy {
    dynamic "included_path" {
      for_each = local.cont9_index.included_paths
      content { 
        path = included_path.key
        }
    }
    dynamic "excluded_path" {
      for_each = local.cont9_index.excluded_paths
      content { 
        path = excluded_path.key
        }
    }
    dynamic "composite_index" {
      for_each = can(local.cont9.compositeIndexes[0]) ? [1] : []
      content{
        dynamic "index" {
        for_each = local.cont9_index.composite_indexes
        content {
          path  = index.key
          order = index.value
      }
      }
      }
      
      
    }
}
}

data azurerm_cosmosdb_sql_database sql1 {
  name = "amsreport"
  resource_group_name = data.azurerm_cosmosdb_account.cosmos.resource_group_name
  account_name = data.azurerm_cosmosdb_account.cosmos.name
}
resource "azurerm_cosmosdb_sql_container" "cont10" {
  name                  = "sync-info"
  resource_group_name   = data.azurerm_cosmosdb_account.cosmos.resource_group_name
  account_name          = data.azurerm_cosmosdb_account.cosmos.name
  database_name         = data.azurerm_cosmosdb_sql_database.sql1.name
  partition_key_path    = "/executionDateTime"
  partition_key_version = 1
    indexing_policy {
    dynamic "included_path" {
      for_each = local.cont10_index.included_paths
      content { 
        path = included_path.key
        }
    }
    dynamic "excluded_path" {
      for_each = local.cont10_index.excluded_paths
      content { 
        path = excluded_path.key
        }
    }
    dynamic "composite_index" {
      for_each = can(local.cont10.compositeIndexes[0]) ? [1] : []
      content{
        dynamic "index" {
        for_each = local.cont10_index.composite_indexes
        content {
          path  = index.key
          order = index.value
      }
      }
      }
      
      
    }
}

}
resource "azurerm_cosmosdb_sql_container" "cont11" {
  name                  = "events-summary"
  resource_group_name   = data.azurerm_cosmosdb_account.cosmos.resource_group_name
  account_name          = data.azurerm_cosmosdb_account.cosmos.name
  database_name         = data.azurerm_cosmosdb_sql_database.sql1.name
  partition_key_path    = "/reportType"
  partition_key_version = 1
    indexing_policy {
    dynamic "included_path" {
      for_each = local.cont11_index.included_paths
      content { 
        path = included_path.key
        }
    }
    dynamic "excluded_path" {
      for_each = local.cont11_index.excluded_paths
      content { 
        path = excluded_path.key
        }
    }
    dynamic "composite_index" {
      for_each = can(local.cont11.compositeIndexes[0]) ? [1] : []
      content{
        dynamic "index" {
        for_each = local.cont11_index.composite_indexes
        content {
          path  = index.key
          order = index.value
      }
      }
      }
    }
    }
}
