terraform{
  required_providers {
    terratowns = {
      source = "local.providers/local/terratowns"
      version = "1.0.0"
    }
  }
}

# module "terrahouse_aws" {
#   source = "./modules/terrahouse_aws"
#   user_uid = var.user_uuid
#   bucket_name = var.bucket_name
#   index_html_filepath = var.index_html_filepath
#   error_html_filepath = var.error_html_filepath
#   content_version = var.content_version
#   assets_path = var.assets_path
# }

provider "terratowns" {
  endpoint = "http://localhost:4567/api"
  user_uuid="e328f4ab-b99f-421c-84c9-4ccea042c7d1" 
  token="8b45e9345fb-v848-483c-b793-97ba77ebf8e0"
}
resource "terratowns_home" "home" {
  name = "How to play Snakes & Ladder in 2023!"
  description = <<DESCRIPTION
One hundred squares full of traps and tricks… Roll the dice and try your luck! Ladders will take you up but Snakes will take you down! 
DESCRIPTION
  #domain_name = module.terrahouse_aws.cloudfront_url
  domain_name = "3fdq3gz.cloudfront.net"
  town = "gamers-grotto"
  content_version = 1