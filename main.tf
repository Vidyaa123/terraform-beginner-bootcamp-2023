terraform{
#backend "remote" {
  #  hostname = "app.terraform.io"
  #  organization = "ExamPro"

  #  workspaces {
  #    name = "terra-house-1"
  #  }
  # }
  cloud {
   organization = "Vidyaa"
   workspaces {
     name = "Terra-Clicks"
   }
  }
}

module "terrahouse_aws" {
  source = "./modules/terrahouse_aws"
  user_uid = var.user_uid
  bucket_name = var.bucket_name
  index_html_filepath = var.index_html_filepath
  error_html_filepath = var.error_html_filepath
}

