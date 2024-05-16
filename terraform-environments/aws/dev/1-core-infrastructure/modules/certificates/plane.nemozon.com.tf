
module "plane-nemozon-com" {
  source = "./nested"
  name = "plane.nemozon.com"
  domain_name = "*.plane.nemozon.com"
  subject_alternative_names = ["plane.nemozon.com"]
  route53_zone_id = var.route53_zones_ids["nemozon-com"].hostedzone_id
  local-tags = var.local-tags
}


output "plane-nemozon-com" {
  value = module.plane-nemozon-com
}