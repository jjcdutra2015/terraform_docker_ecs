resource "aws_lb" "alb" {
  name            = "ECS-Django"
  security_groups = [aws_security_group.alb.id]
  subnets         = [module.vpc.public_subnets]
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.alb.arn
  port              = "8000"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.front_end.arn
  }
}
