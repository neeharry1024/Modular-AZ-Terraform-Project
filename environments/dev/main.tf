resource "azurerm_resource_group" "rg" {
  name     = "dev-rg"
  location = "centralindia"
}

module "network" {
  source = "../../modules/network"

  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  vnet_name           = "dev-vnet"
  subnet_name         = "dev-subnet"
}

module "vm" {
  source = "../../modules/vm"

  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  vm_name             = "dev-vm"
  subnet_id           = module.network.subnet_id
  admin_username      = "azureuser"
  public_key          = file("~/.ssh/id_rsa.pub")
}
