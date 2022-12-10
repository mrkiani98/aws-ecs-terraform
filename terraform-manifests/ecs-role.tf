# ecs execution role
data "aws_iam_policy" "ecs_execution_role" {
  name = "AmazonECSTaskExecutionRolePolicy"
}

resource "aws_iam_role" "ecs_task_execution_role" {
  name        = "ecs_task_execution_role"
  description = "ecs_task_execution_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
      }
    ]
  })

  managed_policy_arns = [ data.aws_iam_policy.ecs_execution_role.arn ]
}

# ecs dynamodb role
resource "aws_iam_policy" "dynamodb_fullaccess_kiani_table_policy" {
  name        = "dynamodb_fullaccess_kiani_table_policy"
  path        = "/"
  description = "dynamodb fullaccess only kiani table policy"
  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": [
                "dynamodb:DeleteItem",
                "dynamodb:DescribeContributorInsights",
                "dynamodb:RestoreTableToPointInTime",
                "dynamodb:ListTagsOfResource",
                "dynamodb:CreateTableReplica",
                "dynamodb:UpdateContributorInsights",
                "dynamodb:UpdateGlobalTable",
                "dynamodb:CreateBackup",
                "dynamodb:DeleteTable",
                "dynamodb:UpdateTableReplicaAutoScaling",
                "dynamodb:UpdateContinuousBackups",
                "dynamodb:TagResource",
                "dynamodb:PartiQLSelect",
                "dynamodb:DescribeTable",
                "dynamodb:PartiQLInsert",
                "dynamodb:GetItem",
                "dynamodb:DescribeContinuousBackups",
                "dynamodb:CreateGlobalTable",
                "dynamodb:DescribeKinesisStreamingDestination",
                "dynamodb:EnableKinesisStreamingDestination",
                "dynamodb:ImportTable",
                "dynamodb:BatchGetItem",
                "dynamodb:DisableKinesisStreamingDestination",
                "dynamodb:UpdateTimeToLive",
                "dynamodb:BatchWriteItem",
                "dynamodb:ConditionCheckItem",
                "dynamodb:UntagResource",
                "dynamodb:PutItem",
                "dynamodb:PartiQLUpdate",
                "dynamodb:Scan",
                "dynamodb:Query",
                "dynamodb:StartAwsBackupJob",
                "dynamodb:UpdateItem",
                "dynamodb:DeleteTableReplica",
                "dynamodb:DescribeTimeToLive",
                "dynamodb:CreateTable",
                "dynamodb:UpdateGlobalTableSettings",
                "dynamodb:RestoreTableFromAwsBackup",
                "dynamodb:RestoreTableFromBackup",
                "dynamodb:ExportTableToPointInTime",
                "dynamodb:UpdateTable",
                "dynamodb:PartiQLDelete",
                "dynamodb:DescribeTableReplicaAutoScaling"
            ],
            "Resource": [
                "${module.dynamodb_table.dynamodb_table_arn}"
            ]
        }
    ]
})
}

resource "aws_iam_role" "ecs_task_connect_to_dynamodb" {
  name        = "ecs_task_connecto_to_dynamodb"
  description = "ecs_task_connecto_to_dynamodb"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
      }
    ]
  })

  managed_policy_arns = [ aws_iam_policy.dynamodb_fullaccess_kiani_table_policy.arn ]
}