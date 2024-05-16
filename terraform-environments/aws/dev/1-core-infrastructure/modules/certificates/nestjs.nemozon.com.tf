
module "nestjs-nemozon-com" {
  source = "./nested"
  name = "nestjs.nemozon.com"
  domain_name = "*.nestjs.nemozon.com"
  subject_alternative_names = ["nestjs.nemozon.com"]
  route53_zone_id = var.route53_zones_ids["nemozon-com"].hostedzone_id
  local-tags = var.local-tags
}


output "nestjs-nemozon-com" {
  value = module.nestjs-nemozon-com
}