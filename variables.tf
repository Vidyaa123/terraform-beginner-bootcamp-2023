
variable "teacherseat_user_uuid" {
  description = "Unique identifier for a user"
  type        = string
}


variable "terratowns_endpoint" {
  description = "Unique identifier for a user"
  type        = string
}
variable "terratowns_access_token" {
  description = "Unique identifier for a user"
  type        = string
}

variable "snakes" {
  type = object({
    public_path = string
    content_version = number
  })
}

variable "cakes" {
  type = object({
    public_path = string
    content_version = number
  })
}