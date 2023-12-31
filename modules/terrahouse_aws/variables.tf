
variable "user_uuid" {
  description = "Unique identifier for a user"
  type        = string
  validation {
    condition     = can(regex("^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$", var.user_uuid))
    error_message = "user_uuid must be a valid UUID (e.g., 123e4567-e89b-12d3-a456-426655440000)"
  }
}

# variable "bucket_name" {
#   description = "The name of the S3 bucket"
#   type        = string

#   validation {
#     condition     = (
#       length(var.bucket_name) >= 3 && length(var.bucket_name) <= 63 && 
#       can(regex("^[a-z0-9][a-z0-9-.]*[a-z0-9]$", var.bucket_name))
#     )
#     error_message = "The bucket name must be between 3 and 63 characters, start and end with a lowercase letter or number, and can contain only lowercase letters, numbers, hyphens, and dots."
#   }
# }

variable "public_path" {
  description = "The file path for the public directory"
  type        = string
}

variable "content_version" {
  description = "The content version. Should be a positive integer starting at 1."
  type        = number

  validation {
    condition     = var.content_version > 0 && floor(var.content_version) == var.content_version
    error_message = "The content_version must be a positive integer starting at 1."
  }
}
