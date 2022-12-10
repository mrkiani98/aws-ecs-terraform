module "dynamodb_table" {
  source  = "terraform-aws-modules/dynamodb-table/aws"
  version = "3.1.1"

  name        = var.dynamodb_table_name
  hash_key    = "id"
  table_class = "STANDARD"

  attributes = [
    {
      name = "id"
      type = "N"
    }
  ]

  tags = local.common_tags
}

variable "dynamodb_table_name" {
    type        = string
    description = "dynamodb table name"
}