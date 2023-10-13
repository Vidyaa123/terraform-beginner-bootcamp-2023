## Terrahouse AWS 

```tf
module "home_snakes" {
  source = "./modules/terrahome_aws"
  user_uuid = var.teacherseat_user_uuid
  public_path = var.snakes_public_path
  content_version = var.content_version
}
```

THe public directory expects the following:
- index.html
- error.html
- assets

ALl top level files in assets will be copied, but not any subdirectories.