# AWS EC2 Security Group Terraform Module
# Security Group for Private EC2 Instances
module "private_sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "4.13.1"

  name = "private-sg"
  description = "Security Group with HTTP port open for entire VPC Block (IPv4 CIDR), egress ports are all world open"
  vpc_id = module.vpc.vpc_id
  # Ingress Rules & CIDR Blocks
  ingress_rules = ["http-80-tcp"]
  ingress_cidr_blocks = [module.vpc.vpc_cidr_block]
  ingress_with_cidr_blocks = [
    {
      from_port   = 3000
      to_port     = 3000
      protocol    = "tcp"
      description = "kiani ecs task ports"
      cidr_blocks = module.vpc.vpc_cidr_block
    }
  ]
  # Egress Rule - all-all open
  egress_rules = ["all-all"]
  tags = local.common_tags
}

