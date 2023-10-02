terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.17.0"
    }
  }
}

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket
resource "aws_s3_bucket" "Terra_Clicks_Bucket" {
  bucket = var.bucket_name

    tags = {
    UserUid = var.user_uid
    
  }
}
