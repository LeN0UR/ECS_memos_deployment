output "ecs_cluster_id" {
  description = "The ID of the ECS cluster running the Memos application."
  value       = aws_ecs_cluster.memos_ecs.id
}

output "ecs_service_name" {
  description = "The name of the ECS service that manages the Memos task."
  value       = aws_ecs_service.memos_service.name
}

output "task_definition_arn" {
  description = "The ARN of the ECS task definition that runs the Memos container."
  value       = aws_ecs_task_definition.memos_task_def.arn
}

output "log_group_name" {
  description = "The name of the CloudWatch Log Group where Memos application logs are stored."
  value       = aws_cloudwatch_log_group.cloudwatch.name
}

