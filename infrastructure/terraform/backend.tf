# To use this backend, ensure you have created the S3 bucket and DynamoDB table.
# Modify bucket and dynamo_table names to match your resources.
#
# terraform {
#   backend "s3" {
#     bucket         = "mini-idp-terraform-state"
#     key            = "dev/terraform.tfstate"
#     region         = "us-east-1"
#     encrypt        = true
#     dynamodb_table = "mini-idp-terraform-locks"
#   }
# }
