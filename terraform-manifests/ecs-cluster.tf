module "ecs" {
  source  = "terraform-aws-modules/ecs/aws"
  version = "4.1.1"

  cluster_name = local.name

  cluster_configuration = {
    execute_command_configuration = {
      logging = "OVERRIDE"
      log_configuration = {
        cloud_watch_log_group_name = aws_cloudwatch_log_group.this.name
      }
    }
  }
  tags = local.common_tags
}





## logging
resource "aws_cloudwatch_log_group" "this" {
  name              = "/aws/ecs/kiani"
  retention_in_days = 7
}

## task defintion
resource "aws_ecs_task_definition" "kiani_task" {
  family = "kiani-app-td"
  network_mode = "awsvpc"
  cpu = "256"
  memory = "512"
  requires_compatibilities = ["FARGATE"]
  runtime_platform {
    operating_system_family = "LINUX"
    cpu_architecture = "X86_64"
  }
  execution_role_arn = aws_iam_role.ecs_task_execution_role.arn
  task_role_arn = aws_iam_role.ecs_task_connect_to_dynamodb.arn
  container_definitions = <<EOF
[
  {
            "logConfiguration": {
                "logDriver": "awslogs",
                "options": {
                    "awslogs-group": "${aws_cloudwatch_log_group.this.name}",
                    "awslogs-region": "ap-southeast-1",
                    "awslogs-stream-prefix": "fargate"
                }
            },
            "portMappings": [
                {
                    "hostPort": 3000,
                    "protocol": "tcp",
                    "containerPort": 3000
                }
            ],
            "name": "kiani-app",
            "image": "hello-world",
            "memory": 256
        }
]
EOF
}

## ECS services
resource "aws_ecs_service" "kiani-service" {
  name            = "kiani-service"
  cluster         = module.ecs.cluster_id
  task_definition = aws_ecs_task_definition.kiani_task.arn
  desired_count   = 2
  launch_type = "FARGATE"
#   deployment_controller {
#     type = "FARGATE"
#   }
  network_configuration {
      subnets         = module.vpc.private_subnets[*]
      security_groups = [module.private_sg.security_group_id]
  }
  load_balancer {
    target_group_arn = module.alb.target_group_arns[0]
    container_name   = "kiani-app"
    container_port   = 3000
  }
}