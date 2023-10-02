terraform{

}

module "terrahouse_aws" {
  source = "./modules/terrahouse_aws"
  user_uid = var.user_uid
  bucket_name = var.bucket_name
}

