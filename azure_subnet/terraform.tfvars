vnet_subnet = {

    subnet1 = {
        name  = "dev-subnet"
        resource_group_name  = "shubham_rg_test"
        virtual_network_name = "shubham-vnet-dev"
        address_prefixes     = ["10.0.1.0/25"]
    }

    subnet2 = {
        name  = "prod-subnet"
        resource_group_name  = "shubham_rg_test1"
        virtual_network_name = "shubham-vnet-prod"
        address_prefixes     = ["10.0.1.0/25"]
    }

}