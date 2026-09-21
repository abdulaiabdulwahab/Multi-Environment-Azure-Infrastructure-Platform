variable "subscription_id" {
  type = string
}

variable "location" {
  type    = string
  default = "canadacentral"
}

variable "project_name" {
  type    = string
  default = "platform"
}

variable "environment" {
  type = string
}

variable "vnet_address_space" {
  type = list(string)
}

variable "subnets" {

  type = map(object({
    address_prefixes = list(string)
  }))
}