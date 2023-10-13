output "bucket_name" {
  description = "Bucket name for static website hosting"
  value = module.terrahouse_aws.bucket_name
}

output "s3_website_endpoint" {
  description = "S3 Static website hosting endpoint"
  value = module.terrahouse_aws.website_endpoint
}

output "cloudfront_url" {
  description = "The CloudFront Distribution Domain Name"
  value = module.terrahouse_aws.cloudfront_url
}