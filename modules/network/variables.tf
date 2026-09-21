variable "resource_group_name" {
  type = string
}

variable "location" {
  type = string
}

variable "vnet_name" {
  type = string
}

variable "address_space" {
  type = list(string)
}

variable "subnets" {

  description = "Map containing subnet names and address ranges"

  type = map(object({
    address_prefixes = list(string)
  }))
}

variable "tags" {
  type    = map(string)
  default = {}
}