terraform{
  required_providers {
    terratowns = {
      source = "local.providers/local/terratowns"
      version = "1.0.0"
    }
  }

# backend "remote" {
#   hostname = "app.terraform.io"
#   organization = "Vidyaa"

#   workspaces {
#     name = "Terra-Clicks"
#   }
# }

cloud {
  organization = "Vidyaa"
  workspaces {
    name = "Terra-Clicks"
  }
}
}

provider "terratowns" {
  endpoint = var.terratowns_endpoint
  user_uuid = var.teacherseat_user_uuid
  token = var.terratowns_access_token

}

module "home_snakes_hosting" {
  source = "./modules/terrahouse_aws"
  user_uuid = var.teacherseat_user_uuid
  public_path = var.snakes.public_path
  content_version = var.snakes.content_version
}

resource "terratowns_home" "home" {
  name = "How to play Snakes & Ladder!"
  description = <<DESCRIPTION
One hundred squares full of traps and tricks… Roll the dice and try your luck! 
Ladders will take you up but Snakes will take you down! 
DESCRIPTION
  domain_name = module.home_snakes_hosting.domain_name
  town = "missingo"
  content_version = var.snakes.content_version
}
# Secound house resource
module "home_cakes_hosting" {
  source = "./modules/terrahouse_aws"
  user_uuid = var.teacherseat_user_uuid
  public_path = var.cakes.public_path
  content_version = var.cakes.content_version
}

resource "terratowns_home" "home_cakes" {
  name = "A.R. Rahman Live in Concert"
  description = <<DESCRIPTION
Music Madness!!
DESCRIPTION
  domain_name = module.home_cakes_hosting.domain_name
  town = "melomaniac-mansion"
  content_version = var.cakes.content_version
}