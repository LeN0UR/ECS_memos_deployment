# alb
resource "aws_lb" "memos_alb" {
  name               = var.alb_name
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.security_group_id_alb]

  # use the list passed from root, not root resources directly
  subnets = var.public_subnet_ids
  
  tags = {
    Environment = var.environment_tag
  }
}

# Target group
resource "aws_lb_target_group" "memos_tg" {
  name     = var.alb_tg_name
  port     = var.app_port
  target_type = "ip" #If you leave this out by accident it defaults to instance 
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    path                = var.health_check_path
    matcher             = var.health_check_matcher
    interval            = var.health_check_interval
    timeout             = var.health_check_timeout
    healthy_threshold   = var.health_check_healthy_threshold
    unhealthy_threshold = var.health_check_unhealthy_threshold
  }

  tags = {
    Name        = var.alb_tg_name
    Environment = var.environment_tag
  }
}

# HTTP Listener (redirecting to HTTPS)
resource "aws_lb_listener" "redirect_http" {
  load_balancer_arn = aws_lb.memos_alb.arn
  port              = var.http_port
  protocol          = "HTTP"

  default_action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}

# HTTPS Listener (TLS termination)
resource "aws_lb_listener" "https" {
  load_balancer_arn = aws_lb.memos_alb.arn   
  port              = var.https_port        
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = var.acm_certificate_arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.memos_tg.arn   
  }
}
