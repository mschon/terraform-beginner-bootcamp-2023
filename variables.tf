variable "terratowns_access_token" {
  type = string
}

variable "teacherseat_user_uuid" {
  type = string
}

variable "terratowns_endpoint" {
  type = string
}

variable "upper_peninsula" {
  type = object({
    public_path = string
    content_version = number
  })
}

variable "sausage" {
  type = object({
    public_path = string
    content_version = number
  })
}
