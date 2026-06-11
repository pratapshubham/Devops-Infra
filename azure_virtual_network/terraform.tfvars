vnet_network = {

 network1 = {
    name                = "shubham-vnet-dev"
    location            = "eastus"
    resource_group_name = "shubham_rg_test"
    address_space       = ["10.0.0.0/24"]
  }
  network2 = {
    name                = "shubham-vnet-prod"
    location            = "centralindia"
    resource_group_name = "shubham_rg_test1"
    address_space       = ["10.124.0.0/24"]
  }

}