terraform {
  required_providers {
    terratowns = {
      source = "local.providers/local/terratowns"
      version = "1.0.0"
    }
  }

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

provider "terratowns" {
  endpoint = "http://localhost:4567/api"
  user_uuid = "e328f4ab-b99f-421c-84c9-4ccea042c7d1"
  token = "9b49b3fb-b8e9-483c-b703-97ba88eef8e0"
}

#module "terrahouse_aws" {
#  source = "./modules/terrahouse_aws"
#  user_uuid = var.user_uuid
#  bucket_name = var.bucket_name
#  index_html_filepath = var.index_html_filepath
#  error_html_filepath = var.error_html_filepath
#  content_version = var.content_version
#  assets_path = var.assets_path
#}

# available towns:
# melomaniac-mansion
# cooker-cove
# video-valley
# the-nomad-pad
# gamers-grotto

resource "terratowns_home" "home" {
  name = "Places to visit in Michigan's Upper Peninsula"
  description = <<DESCRIPTION
Michigan's Upper Peninsula is a great place to enjoy the outdoors. This is a collection of places to visit. 
  DESCRIPTION
  #domain_name = module.terrahouse_aws.cloudfront_url
  domain_name = "abcdefg.cloudfront.net"
  town = "the-nomad-pad"
  content_version = 1
}
