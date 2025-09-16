variable "resource_group_name" {
  type    = string
  default = "azureVotingApp"
}

variable "location" {
  type    = string
  default = "westeurope"
}

variable "container_group_name" {
  type    = string
  default = "azure-vote-group"
}

variable "dns_name_label" {
  type    = string
  default = ""
}

variable "front_image" {
  type    = string
  default = "votingacremanueleromano.azurecr.io/azure-vote-front:latest"
}

variable "acr_username" {
  type = string
}

variable "acr_password" {
  type = string
  sensitive = true
}

variable "docker_username" {
  type = string
}

variable "docker_password" {
  type = string
  sensitive = true
}

variable "tags" {
  type = map(string)
  default = {}
}
