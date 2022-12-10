output "ecs_task_execution_role_arn" {
  description = "The arn of the ecs_task_execution_role_arn"
  value       = aws_iam_role.ecs_task_execution_role.arn
}

output "ecs_task_connect_to_dynamodb" {
  description = "The arn of the ecs_task_connect_to_dynamodb"
  value       = aws_iam_role.ecs_task_connect_to_dynamodb.arn
}