storage_account = {

sa1 = {
    name                     = "shubhampratapprod1"
    resource_group_name      = "shubham_rg_test"
    location                 = "eastus"
    account_tier             = "Standard"
    account_replication_type = "LRS"
    tags = {
      environment = "production"
    }
  }
 
}