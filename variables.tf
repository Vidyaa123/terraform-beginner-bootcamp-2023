
variable "user_uid" {
  description = "Unique identifier for a user"
  type        = string
}

variable "bucket_name" {
  description = "The name of the S3 bucket"
  type        = string
}

variable "index_html_filepath" {
  description = "The file path for index.html"
  type        = string
}

variable "error_html_filepath" {
  description = "The file path for error.html"
  type        = string
}

variable "content_version" {
  type        = number
}