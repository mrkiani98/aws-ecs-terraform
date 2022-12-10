# aws-terraform-ecs

## Project overview

1. Leveraging express framework to deploy a very basic and light Nodejs application.
1. This project is mainly about deploying a containerized application in AWS ECS cluster by using terraform.
1. Having basic CRUD functionality.with a dynamodb table.
1. Using Github action template to deploy an application in AWS ECS.

## Terraform manifests overview
1. Creating a 3-tier level design VPC by having public and private subnets and NAT gateway.
1. Set up desired security groups.
1. Set up required IAM policies and roles and dynamically set these related values in the task definition.
1. Provision ECR and dynamodb table.
1. Setup ECS cluster and with a sample service and task definition with cloudwatch log group.
1. Set up AWS ALB and dynamically connect it to AWS ECS tasks.

