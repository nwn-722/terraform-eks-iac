
module "nextjs-nemozon-com" {
  source = "./nested"
  name = "nextjs.nemozon.com"
  domain_name = "*.nextjs.nemozon.com"
  subject_alternative_names = ["nextjs.nemozon.com"]
  route53_zone_id = var.route53_zones_ids["nemozon-com"].hostedzone_id
  local-tags = var.local-tags
}


output "nextjs-nemozon-com" {
  value = module.nextjs-nemozon-com
}