resource "aws_lb" "alb" {
  name               = "alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.sg_alb.id, aws_security_group.default_rules.id]
  subnets            = [for subnet in aws_subnet.public : subnet.id]

}

#target
resource "aws_lb_target_group" "alb-target" {
  name     = "lb-alb-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.main.id

  health_check {
    path = "/"
    port = "traffic-port"
  }
}

#attachment
resource "aws_lb_target_group_attachment" "attac" {
  count            = 1
  target_group_arn = aws_lb_target_group.alb-target.arn
  target_id        = aws_instance.nginx-server[count.index].id
  port             = 80
}

#alb listener 
resource "aws_lb_listener" "listener" {
  load_balancer_arn = aws_lb.alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alb-target.arn
  }
}