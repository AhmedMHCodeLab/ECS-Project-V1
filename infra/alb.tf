resource "aws_lb" "alb" {
  name               = "ecs-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_sg.id]
  subnets            = [aws_subnet.PublicSub1.id, aws_subnet.PublicSub2.id]

  tags = {
    Name = "ECS-ALB"
  }
}

resource "aws_lb_target_group" "app" {
  name        = "ecs-target-group"
  port        = 80 
  protocol    = "HTTP"
  vpc_id      = aws_vpc.main.id
  target_type = "ip"  

  tags = {
    Name = "ECS Target Group"
  }
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.app.arn
  }
}
