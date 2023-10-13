terraform{
  required_providers {
    terratowns = {
      source = "local.providers/local/terratowns"
      version = "1.0.0"
    }
  }
}

module "terrahouse_aws" {
  source = "./modules/terrahouse_aws"
  user_uuid = var.teacherseat_user_uuid
  index_html_filepath = var.index_html_filepath
  error_html_filepath = var.error_html_filepath
  content_version = var.content_version
  assets_path = var.assets_path
}

provider "terratowns" {
  endpoint = var.terratowns_endpoint
  user_uuid = var.teacherseat_user_uuid
  token = var.terratowns_access_token

}
resource "terratowns_home" "home" {
  name = "How to play Snakes & Ladder!"
  description = <<DESCRIPTION
One hundred squares full of traps and tricks… Roll the dice and try your luck! Ladders will take you up but Snakes will take you down! 
DESCRIPTION
  domain_name = module.terrahouse_aws.cloudfront_url
  #  domain_name = "3fsfsfs34.cloudfront.net"
  town = "missingo"
  content_version = 1
}