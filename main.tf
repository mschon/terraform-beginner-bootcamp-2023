terraform {
  #backend "remote" {
  #  hostname = "app.terraform.io"
  #  organization = "mschonert"

  #  workspaces {
  #    name = "terra-house-1"
  #  }
  #}
  #cloud {
  #  organization = "mschonert"
  #  workspaces {
  #    name = "terra-house-1"
  #  }
  #}
}

module "terrahouse_aws" {
  source = "./modules/terrahouse_aws"
  user_uuid = var.user_uuid
  bucket_name = var.bucket_name
}
