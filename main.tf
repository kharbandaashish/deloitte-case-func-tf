resource "azurerm_resource_group" "deloitte_rg" {
  name     = "${var.resource_group_name}"
  location = "${var.location}"
} 

resource "azurerm_storage_account" "deloitte_storage" {
  name                     = "${var.storage_account_name}"
  resource_group_name      = azurerm_resource_group.deloitte_rg.name
  location                 = azurerm_resource_group.deloitte_rg.location
  account_tier             = "${var.storage_account_tier}"
  account_replication_type = "${var.storage_account_replication_type}"
}

resource "azurerm_service_plan" "deloitte_app_plan" {
  name                = "${var.app_plan_name}"
  location            = azurerm_resource_group.deloitte_rg.location
  resource_group_name = azurerm_resource_group.deloitte_rg.name
  os_type             = "${var.app_os_type}"
  sku_name            = "${var.app_sku_name}"
}

resource "azurerm_linux_function_app" "deloitte_function_app" {
  name                = "${var.function_app_name}"
  location            = azurerm_resource_group.deloitte_rg.location
  resource_group_name = azurerm_resource_group.deloitte_rg.name
  service_plan_id     = azurerm_service_plan.deloitte_app_plan.id

  storage_account_name       = azurerm_storage_account.deloitte_storage.name
  storage_account_access_key = azurerm_storage_account.deloitte_storage.primary_access_key

  site_config {
    application_stack {
      python_version = "${var.python_version}"
    }
  }
}

resource "azurerm_function_app_function" "deloitte_function_app_func" {
  name            = "${var.function_app_func_name}"
  function_app_id = azurerm_linux_function_app.deloitte_function_app.id
  language        = "${var.func_language}"
  file {
    name    = "${var.file_name}"
    content = file("${var.file_name}")
  }
  test_data = jsonencode({
    "name" = "Azure"
  })
  config_json = jsonencode({
    "scriptFile": "__init__.py" 
    "bindings" = [
      {
        "authLevel" = "anonymous"
        "direction" = "in"
        "methods" = [
          "get",
          "post",
        ]
        "name" = "req"
        "type" = "httpTrigger"
      },
      {
        "direction" = "out"
        "name"      = "$return"
        "type"      = "http"
      },
    ]
  })
}