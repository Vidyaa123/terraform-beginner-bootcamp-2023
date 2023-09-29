

resource "random_string" "bucket_name" {
  length = 32
  lower = true
  upper = false
  special = false
}

resource "aws_s3_bucket" "example" {
  bucket = random_string.bucket_name.result

    #tags = {
    #UserUid = var.user_uid
    #Environment = "Dev"
  #}
}

