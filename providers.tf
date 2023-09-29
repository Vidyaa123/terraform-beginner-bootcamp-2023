 terraform {
#   cloud {
#     organization = "Vidyaa"

#     workspaces {
#       name = "Terra-Clicks"
#     }
#   }
  required_providers {
    random = {
      source = "hashicorp/random"
      version = "3.5.1"
    }
    aws = {
      source = "hashicorp/aws"
      version = "5.17.0"
    }
  }
}

provider "aws" {
  region = "eu-west-2"
  
}

provider "random" {
  # Configuration options
}