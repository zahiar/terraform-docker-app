locals {
  ecs-task-def = [
    for service, service-config in local.config : {
      name   = service
      image  = service-config.image
      cpu    = 1024
      memory = 1024

      environment = [
        for key, value in service-config.environment :
        {
          name  = key,
          value = value
        }
      ]

      portMappings = [
        for port in service-config.ports :
        {
          containerPort = split(":", port)[0]

          // If a host port was set use it, otherwise resort to the default value, which will dynamically one
          hostPort = length(split(":", port)) > 1 ? split(":", port)[1] : 0
          protocol = "tcp",
        }
      ]

      essential = true
    }
  ]
}

output "ecs-task-definition-json" {
  description = "AWS ECS Task Definition JSON"
  value       = jsonencode(local.ecs-task-def)
}
