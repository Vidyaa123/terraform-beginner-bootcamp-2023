
variable "user_uid" {
  description = "Unique identifier for a user"
  type        = string
  validation {
    condition     = can(regex("^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$", var.user_uid))
    error_message = "user_uid must be a valid UUID (e.g., 123e4567-e89b-12d3-a456-426655440000)"
  }
}