variable "app" {
  description = "Details about the app"
  type = object({
    name = string
    prefix = string
    env = string
    location_primary = string
  })
}