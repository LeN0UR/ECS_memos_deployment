# ECS Cluster

resource "aws_ecs_cluster" "memos_ecs" {
  name = var.ecs_cluster_name
}

# CloudWatch Log Group

resource "aws_cloudwatch_log_group" "cloudwatch" {
  name              = var.log_group_name
  retention_in_days = var.log_retention_days
}

# IAM Execution Role

resource "aws_iam_role" "ecs_execution_role" {
  name = var.ecs_execution_role_name

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action    = "sts:AssumeRole"
        Effect    = "Allow"
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
      }
    ]
  })

  tags = {
    Name        = var.ecs_execution_role_name
    Environment = var.environment_tag
  }
}

resource "aws_iam_role_policy_attachment" "ecs_execution" {
  role       = aws_iam_role.ecs_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

# Task Definition

resource "aws_ecs_task_definition" "memos_task_def" {
  family                   = var.task_definition_family
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = var.task_definition_cpu
  memory                   = var.task_definition_memory
  execution_role_arn       = aws_iam_role.ecs_execution_role.arn

  container_definitions = jsonencode([
    {
      name  = var.container_name
      image = "${var.container_image}:${var.image_tag}"

      portMappings = [
        {
          containerPort = var.app_port
          protocol      = "tcp"
        }
      ]

      environment = [
        for k, v in var.container_environment :
        {
          name  = k
          value = v
        }
      ]

      logConfiguration = {
        logDriver = "awslogs"
        options = {
          "awslogs-group"        = aws_cloudwatch_log_group.cloudwatch.name
          "awslogs-region"       = var.aws_region
          "awslogs-stream-prefix" = var.log_stream_prefix
        }
      }
    }
  ])
}

# ECS Service

resource "aws_ecs_service" "memos_service" {
  name            = var.ecs_service_name
  cluster         = aws_ecs_cluster.memos_ecs.id
  task_definition = aws_ecs_task_definition.memos_task_def.arn
  desired_count   = var.desired_count
  launch_type     = "FARGATE"

  network_configuration {
    subnets          = var.subnet_ids
    security_groups  = [var.ecs_security_group_id]
    assign_public_ip = var.assign_public_ip
  }

  load_balancer {
    target_group_arn = var.target_group_arn
    container_name   = var.container_name
    container_port   = var.app_port
  }

  lifecycle {
    ignore_changes = [task_definition]
  }
}
