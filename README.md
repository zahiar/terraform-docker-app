# Terraform Docker App Module

A Terraform module that takes in a Docker Compose like config, and outputs valid Docker Compose YAML & AWS ECS Task Definition JSON.
This can be used by other modules to create & deploy a Docker Compose setup or even provision a service in AWS ECS.

## Usage Example
```hcl
module "my-app" {
  source = "zahiar/app/docker"

  config = {
    app : {
      image : "some/docker/image"
      environment : {
        ENV : "VALUE"
      }
    }

    web : {
      image : "some/other/docker/image"
      ports : ["80:80"]
    }
  }
}

output "docker-compose-yaml" {
  value = module.my-app.docker-compose-yaml
}
output "ecs-task-definition-json" {
  value = module.my-app.ecs-task-definition-json
}
```
