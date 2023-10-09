output "bucket_name" {
  description = "Bucket name for our static website hosting"
  value = module.home_upper_peninsula_hosting.bucket_name
}

output "website_endpoint" {
  description = "S3 static website hosting endpoint"
  value = module.home_upper_peninsula_hosting.website_endpoint
}

output "domain_name" {
  description = "Domain name, i.e. CloudFront distribution URL"
  value = module.home_upper_peninsula_hosting.domain_name
}
