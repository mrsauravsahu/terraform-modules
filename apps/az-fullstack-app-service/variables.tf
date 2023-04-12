variable "location" {
  type = string
}

variable "app" {
  type = object({
    prefix = string
    stage = string
  })
}

variable "rg" {
  type = object({
    overriden_name = optional(string)
  })
  default = { }
}
