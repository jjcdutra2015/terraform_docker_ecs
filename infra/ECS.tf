module "ecs" {
  source = "terraform-aws-modules/ecs/aws"

  name = var.ambiente

  fargate_capacity_providers = {
    FARGATE = {
      default_capacity_provider_strategy = {
        weight = 50
      }
    }
  }
}

resource "aws_ecs_task_definition" "Django-API" {
  family                   = "Django-API"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = 256
  memory                   = 512
  execution_role_arn       = aws_iam_role.cargo.arn
  container_definitions = jsoncode(
    [
      {
        "name"      = "producao",
        "image"     = "095878108579.dkr.ecr.us-west-2.amazonaws.com/producao:v1",
        "cpu"       = 256,
        "memory"    = 512,
        "essential" = true
        "portMappings" = [
          {
            "containerPort" = 8000,
            "hostPort"      = 8000
          }
        ]
      }
    ]
  )
}

resource "aws_ecs_service" "Django-API" {
  name            = "Django-API"
  cluster         = module.ecs.cluster_id
  task_definition = aws_ecs_task_definition.Django-API.arn
  desired_count   = 3

  load_balancer {
    target_group_arn = aws_lb_target_group.alvo.arn
    container_name   = "producao"
    container_port   = 8000
  }
}
