variable "config" {
  description = "A map of application services following Docker Compose like syntax"

  type = map(object({
    image : string
    ports : optional(list(string))
    environment : optional(map(string))
    restart : optional(string)
  }))
}

locals {
  config = {
    for service, service-config in var.config : service => defaults(service-config, {
      restart : "always"
    })
  }
}
