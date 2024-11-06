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

output "id" {
  value = azurerm_postgresql_flexible_server.postgres.id
}

output "name" {
  value = azurerm_postgresql_flexible_server.postgres.name
}

output "fqdn" {
  value = azurerm_postgresql_flexible_server.postgres.fqdn
}

output "delegated_subnet_id" {
  value = azurerm_postgresql_flexible_server.postgres.delegated_subnet_id
}

output "private_dns_zone_id" {
  value = azurerm_postgresql_flexible_server.postgres.private_dns_zone_id
}

output "source_server_id" {
  value = azurerm_postgresql_flexible_server.postgres.source_server_id
}
