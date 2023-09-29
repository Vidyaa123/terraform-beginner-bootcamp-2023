



resource "aws_s3_bucket" "Terra_Clicks_Bucket" {
  bucket = var.bucket_name

    tags = {
    UserUid = var.user_uid
    
  }
}

