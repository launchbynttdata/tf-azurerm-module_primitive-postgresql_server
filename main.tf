// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

resource "azurerm_postgresql_flexible_server" "postgres" {
  name                = var.name
  resource_group_name = var.resource_group_name
  location            = var.location

  create_mode  = var.create_mode
  version      = var.postgres_version
  sku_name     = var.sku_name
  storage_mb   = var.storage_mb
  storage_tier = var.storage_tier

  delegated_subnet_id           = var.delegated_subnet_id
  private_dns_zone_id           = var.private_dns_zone_id
  public_network_access_enabled = var.public_network_access_enabled

  backup_retention_days        = var.backup_retention_days
  geo_redundant_backup_enabled = var.geo_redundant_backup_enabled

  dynamic "identity" {
    for_each = coalesce(var.identity_ids, [])
    content {
      type         = "UserAssigned"
      identity_ids = identity.key
    }
  }

  dynamic "authentication" {
    for_each = var.authentication != null ? ["authentication"] : []
    content {
      active_directory_auth_enabled = var.authentication.active_directory_auth_enabled
      password_auth_enabled         = var.authentication.password_auth_enabled
      tenant_id                     = var.authentication.tenant_id
    }
  }

  administrator_login    = var.administrator_login
  administrator_password = var.administrator_password

  dynamic "high_availability" {
    for_each = var.high_availability != null ? ["high_availability"] : []
    content {
      mode                      = var.high_availability.mode
      standby_availability_zone = var.high_availability.standby_availability_zone
    }
  }

  dynamic "maintenance_window" {
    for_each = var.maintenance_window != null ? ["maintenance_window"] : []
    content {
      day_of_week  = var.maintenance_window.day_of_week
      start_hour   = var.maintenance_window.start_hour
      start_minute = var.maintenance_window.start_minute
    }
  }

  source_server_id = var.source_server_id
  zone             = var.zone

  tags = var.tags
}
