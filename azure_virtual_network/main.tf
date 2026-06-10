resource "azurerm_virtual_network" "v-net" {
    for_each = var.vnet_network
    name = each.value.name
    location = each.value.location
    address_space = each.value.address_space
    resource_group_name = each.value.resource_group_name
}