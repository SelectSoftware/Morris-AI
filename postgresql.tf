
resource "azurerm_postgresql_flexible_server" "opendevin_pg" {
  name                = "opendevin-pgsql"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  version             = "14"
  sku_name            = "B1ms"

  administrator_login          = "adminuser"
  administrator_password       = "StrongP@ssw0rd123!"

  storage_mb                   = 32768
  backup_retention_days        = 7
  geo_redundant_backup_enabled = false
  high_availability_mode       = "Disabled"

  authentication {
    active_directory_auth_enabled = false
    password_auth_enabled         = true
  }
}

resource "azurerm_postgresql_flexible_server_firewall_rule" "allow_all" {
  name             = "AllowAll"
  server_name      = azurerm_postgresql_flexible_server.opendevin_pg.name
  resource_group_name = azurerm_resource_group.rg.name
  start_ip_address = "0.0.0.0"
  end_ip_address   = "255.255.255.255"
}
