variable "ami_id" {
  type = string
}

variable "app" {
  description = "Details about the app"
  type = object({
    name = string
  })
  default = {
    name = "BasicCompute"
  }
}

