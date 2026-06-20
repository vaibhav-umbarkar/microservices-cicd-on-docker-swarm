# Existing ALB
resource "aws_lb" "swarm_alb" {
    name               = "swarm-alb"
    internal           = false
    load_balancer_type = "application"

    security_groups = [var.swarm_alb_sg_id]
    subnets         = var.public_subnet_ids
}

# Existing TG for Port 80
resource "aws_lb_target_group" "tg" {
  name        = "swarm-alb-tg"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "instance"

  health_check {
    path                = "/"
    protocol            = "HTTP"
    matcher             = "200"
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }
}

# New TG for Port 3000
resource "aws_lb_target_group" "tg_3000" {
  name        = "swarm-alb-tg-3000"
  port        = 3000
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "instance"

  health_check {
    path                = "/"
    protocol            = "HTTP"
    matcher             = "200"
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }
}

# Existing ASG Attachment
resource "aws_autoscaling_attachment" "worker_tg_attachment" {
  autoscaling_group_name = var.worker_asg_name
  lb_target_group_arn    = aws_lb_target_group.tg.arn
}

# New ASG Attachment for Port 3000
resource "aws_autoscaling_attachment" "worker_tg_attachment_3000" {
  autoscaling_group_name = var.worker_asg_name
  lb_target_group_arn    = aws_lb_target_group.tg_3000.arn
}

# Existing Listener (Port 80)
resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.swarm_alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg.arn
  }
}

# New Listener (Port 3000)
resource "aws_lb_listener" "http_3000" {
  load_balancer_arn = aws_lb.swarm_alb.arn
  port              = 3000
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg_3000.arn
  }
}
