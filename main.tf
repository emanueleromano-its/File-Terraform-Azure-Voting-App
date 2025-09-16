terraform {
  required_version = ">= 1.0.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~>3.0"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "random_id" "suffix" {
  byte_length = 4
}

resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_container_group" "aci" {
  name                = var.container_group_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  os_type             = "Linux"
  ip_address_type     = "Public"
  dns_name_label      = var.dns_name_label != "" ? var.dns_name_label : "azure-vote-app-${random_id.suffix.hex}"

  container {
    name   = "redis"
    image  = "docker.io/library/redis:latest"
    cpu    = 1
    memory = 1

    ports {
      port     = 6379
      protocol = "TCP"
    }

    environment_variables = {
      ALLOW_EMPTY_PASSWORD = "yes"
    }
  }

  container {
    name   = "azure-vote-front"
    image  = var.front_image
    cpu    = 1
    memory = 1

    ports {
      port     = 80
      protocol = "TCP"
    }

    environment_variables = {
      REDIS = "127.0.0.1"
    }
  }

  tags = var.tags

  image_registry_credential {
    server   = "votingacremanueleromano.azurecr.io"
    username = var.acr_username
    password = var.acr_password
  }

  image_registry_credential {
    server   = "docker.io"
    username = var.docker_username
    password = var.docker_password
  }
}
