# Terraform Block
terraform {
  required_version = "~> 1.0" 
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
    # null = {
    #   source = "hashicorp/null"
    #   version = "~> 3.0"
    # }        
  }
  backend "s3" {
    bucket = "kiani-terraform-state-ecs"
    key    = "dev/terraform-ecs/terraform.tfstate"
    region = "ap-southeast-1" 
    dynamodb_table = "terraform-ecs-lock"    
  } 
}

# Provider Block
provider "aws" {
  region  = var.aws_region
  # profile = "admin"
}

