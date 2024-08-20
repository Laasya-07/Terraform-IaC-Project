data "azurerm_resource_group" "rg" {
  name     = "ams-${var.environment}"
}

resource "azurerm_servicebus_namespace" "svcbus" {
  name                = "svcbus-ams-${var.environment}"
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
  sku                 = var.svcbus_sku

  tags = {
    Project = var.project_name
    Environment = var.environment
    Owner = var.owners
    Vendor = var.vendor
    Eng = var.eng
    Deployment_type = var.deployment_type
  }
}

resource "azurerm_servicebus_queue" "queue1" {
  name         = "event-handler-queue"
  namespace_id = azurerm_servicebus_namespace.svcbus.id
  enable_partitioning = var.enable_partitioning
  max_size_in_megabytes = var.max_size_in_megabytes
  dead_lettering_on_message_expiration = var.dead_lettering_on_message_expiration
  depends_on = [azurerm_servicebus_namespace.svcbus,data.azurerm_resource_group.rg]
}

resource "azurerm_servicebus_queue" "queue2" {
  name         = "event-master-report-queue"
  namespace_id = azurerm_servicebus_namespace.svcbus.id
  enable_partitioning = var.enable_partitioning
  max_size_in_megabytes = var.max_size_in_megabytes
  dead_lettering_on_message_expiration = var.dead_lettering_on_message_expiration
  depends_on = [azurerm_servicebus_namespace.svcbus,data.azurerm_resource_group.rg]
}

resource "azurerm_servicebus_queue" "queue3" {
  name         = "notifications-queue"
  namespace_id = azurerm_servicebus_namespace.svcbus.id
  enable_partitioning = var.enable_partitioning
  max_size_in_megabytes = var.max_size_in_megabytes
  dead_lettering_on_message_expiration = var.dead_lettering_on_message_expiration
  depends_on = [azurerm_servicebus_namespace.svcbus,data.azurerm_resource_group.rg]
}

resource "azurerm_servicebus_queue" "queue4" {
  name         = "topic-activity-queue"
  namespace_id = azurerm_servicebus_namespace.svcbus.id
  enable_partitioning = var.enable_partitioning
  max_size_in_megabytes = var.max_size_in_megabytes
  dead_lettering_on_message_expiration = var.dead_lettering_on_message_expiration
  depends_on = [azurerm_servicebus_namespace.svcbus,data.azurerm_resource_group.rg]
}

resource "azurerm_servicebus_queue" "queue5" {
  name         = "topic-comment-logs-modified-queue"
  namespace_id = azurerm_servicebus_namespace.svcbus.id
  enable_partitioning = var.enable_partitioning
  max_size_in_megabytes = var.max_size_in_megabytes
  dead_lettering_on_message_expiration = var.dead_lettering_on_message_expiration
  depends_on = [azurerm_servicebus_namespace.svcbus,data.azurerm_resource_group.rg]
}

resource "azurerm_servicebus_queue" "queue6" {
  name         = "user-modified-queue"
  namespace_id = azurerm_servicebus_namespace.svcbus.id
  enable_partitioning = var.enable_partitioning
  max_size_in_megabytes = var.max_size_in_megabytes
  dead_lettering_on_message_expiration = var.dead_lettering_on_message_expiration
  depends_on = [azurerm_servicebus_namespace.svcbus,data.azurerm_resource_group.rg]
}

resource "azurerm_servicebus_queue" "queue7" {
  name         = "user-roles-modified-queue"
  namespace_id = azurerm_servicebus_namespace.svcbus.id
  enable_partitioning = var.enable_partitioning
  max_size_in_megabytes = var.max_size_in_megabytes
  dead_lettering_on_message_expiration = var.dead_lettering_on_message_expiration
  depends_on = [azurerm_servicebus_namespace.svcbus,data.azurerm_resource_group.rg]
}