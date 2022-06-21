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