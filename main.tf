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

  cloud {
    organization = "mschonert"
    workspaces {
      name = "terra-house-1"
    }
  }
}

provider "terratowns" {
  endpoint = var.terratowns_endpoint
  user_uuid = var.teacherseat_user_uuid
  token = var.terratowns_access_token # do not commit token to repo!
}

# available towns:
# - melomaniac-mansion
# - cooker-cove
# - video-valley
# - the-nomad-pad
# - gamers-grotto

module "home_upper_peninsula_hosting" {
  source = "./modules/terrahome_aws"
  user_uuid = var.teacherseat_user_uuid
  public_path = var.upper_peninsula.public_path
  content_version = var.upper_peninsula.content_version
}

resource "terratowns_home" "home_upper_peninsula" {
  name = "Places to visit in Michigan's Upper Peninsula"
  description = <<DESCRIPTION
Michigan's Upper Peninsula is a great place to enjoy the outdoors. This is a collection of places to visit. 
  DESCRIPTION
  domain_name = module.home_upper_peninsula_hosting.domain_name
  town = "missingo"
  content_version = var.upper_peninsula.content_version
}

module "home_sausage_hosting" {
  source = "./modules/terrahome_aws"
  user_uuid = var.teacherseat_user_uuid
  public_path = var.sausage.public_path
  content_version = var.sausage.content_version
}

resource "terratowns_home" "home_sausage" {
  name = "Winter sausage recipe"
  description = <<DESCRIPTION
How to make homemade winter sausage. 
  DESCRIPTION
  domain_name = module.home_sausage_hosting.domain_name
  town = "missingo"
  content_version = var.sausage.content_version
}
