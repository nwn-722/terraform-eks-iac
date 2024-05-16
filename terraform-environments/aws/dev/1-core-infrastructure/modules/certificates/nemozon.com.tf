
module "nemozon-com" {
  source = "./nested"
  name = "nemozon.com"
  domain_name = "*.nemozon.com"
  subject_alternative_names = ["nemozon.com"]
  route53_zone_id = var.route53_zones_ids["nemozon-com"].hostedzone_id
  local-tags = var.local-tags
}


output "nemozon-com" {
  value = module.nemozon-com
}