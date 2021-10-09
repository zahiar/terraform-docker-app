locals {
  // Remove null values as the `yamlencode` function will include them in the final generated YAML, leading to an
  // invalid docker-compose YAML file
  sanitise-yaml = {
    for service, service-config in local.config : service => {
      for k, v in service-config : k => v if v != null
    }
  }

  docker-compose = {
    version : "2"
    services : local.sanitise-yaml
  }
}

output "docker-compose-yaml" {
  description = "Docker Compose YAML"
  value       = yamlencode(local.docker-compose)
}
