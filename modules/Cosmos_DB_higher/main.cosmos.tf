data azurerm_resource_group rg {
  name = "ams-${var.environment}"
}

resource "azurerm_cosmosdb_account" "db" {
  name                = "cosmos-ams-${var.environment}"
  location            = var.location
  resource_group_name = var.resource_group_name
  offer_type          = "Standard"
  kind                = "GlobalDocumentDB"
  enable_automatic_failover = false
  enable_multiple_write_locations = true

  capacity {
    total_throughput_limit = -1
    }

  geo_location {
    location = data.azurerm_resource_group.rg.location
    failover_priority = 0
  }
  


  consistency_policy {
    consistency_level       = "BoundedStaleness"
    max_interval_in_seconds = 5
    max_staleness_prefix    = 100
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

resource "azurerm_cosmosdb_sql_database" "sql" {
  name                = "ams"
  resource_group_name = azurerm_cosmosdb_account.db.resource_group_name
  account_name        = azurerm_cosmosdb_account.db.name
}

resource "azurerm_cosmosdb_sql_database" "sql1" {
  name                = "amsreport"
  resource_group_name = azurerm_cosmosdb_account.db.resource_group_name
  account_name        = azurerm_cosmosdb_account.db.name
}
