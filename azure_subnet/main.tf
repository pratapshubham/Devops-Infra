resouce "azurerm_subnet" "vnet-subnet" {
    for_each = var.vnet_subnet
    name = each.var.name
    resource_group_name = each.value.resource_group_name
    virtual_network_name = each.value.virtual_network_name
    address_prefixes = each.value.address_prefixes
}