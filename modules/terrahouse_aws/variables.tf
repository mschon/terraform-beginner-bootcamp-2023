variable "user_uuid" {
  description = "The UUID of the user"
  type        = string
  validation {
    condition     = can(regex("^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[1-5][0-9a-fA-F]{3}-[89abAB][0-9a-fA-F]{3}-[0-9a-fA-F]{12}$", var.user_uuid))
    error_message = "The user_uuid value is not a valid UUID."
  }
}

# variable "bucket_name" {
#   description = "Name of the AWS S3 bucket"
#   type        = string

#   validation {
#     condition     = can(regex("^[a-z0-9.-]{3,63}$", var.bucket_name))
#     error_message = "Invalid bucket name. It must be between 3 and 63 characters long and can only contain lowercase letters, numbers, hyphens, and periods."
#   }
# }

variable "index_html_filepath" {
  description = "Path to the index.html file"
  type        = string

  validation {
    condition     = fileexists(var.index_html_filepath)
    error_message = "The specified file path for index.html does not exist."
  }
}

variable "error_html_filepath" {
  description = "Path to the error.html file"
  type        = string

  validation {
    condition     = fileexists(var.error_html_filepath)
    error_message = "The specified file path for error.html does not exist."
  }
}

variable "content_version" {
  description = "Version number for your content"
  type        = number

  validation {
    condition     = var.content_version > 0 && can(regex("^[0-9]+$", tostring(var.content_version)))
    error_message = "Content version must be a positive integer starting at 1."
  }
}

variable "assets_path" {
  description = "Path to assets folder"
  type = string
}
