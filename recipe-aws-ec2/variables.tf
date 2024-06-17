variable "ami_id" {
  type = string
}

variable "instance" {
  type = object({
    is_public = bool
  })
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

