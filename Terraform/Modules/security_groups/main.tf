# ALB Security Group (allows http and https)

resource "aws_security_group" "alb_sg" {
  name        = var.alb_sg_name
  description = "Security group for ALB"
  vpc_id      = var.vpc_id

  # Allow HTTP from anywhere
  ingress {
    from_port   = var.http_port
    to_port     = var.http_port
    protocol    = "tcp"
    cidr_blocks = [var.allow_all_cidr]
  }

  # Allow HTTPS from anywhere
  ingress {
    from_port   = var.https_port
    to_port     = var.https_port
    protocol    = "tcp"
    cidr_blocks = [var.allow_all_cidr]
  }

  # Outbound: allow all
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.allow_all_cidr]  
  }

  tags = {
    Name        = var.alb_sg_name
    Environment = var.environment_tag
  }
}

# ECS Tasks Security Group

resource "aws_security_group" "ecs_sg" {
  name        = var.ecs_sg_name
  description = "Security group for ECS tasks"
  vpc_id      = var.vpc_id

  # Allow app traffic from ALB only (on app_port, e.g. 5230 for Memos)
  ingress {
    from_port       = var.app_port
    to_port         = var.app_port
    protocol        = "tcp"
    security_groups = [aws_security_group.alb_sg.id]
  }

  # Outbound: allow all
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.allow_all_cidr]
  }

  tags = {
    Name        = var.ecs_sg_name
    Environment = var.environment_tag
  }
}
