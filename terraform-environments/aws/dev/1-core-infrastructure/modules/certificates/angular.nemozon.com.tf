
module "angular-nemozon-com" {
  source = "./nested"
  name = "angular.nemozon.com"
  domain_name = "*.angular.nemozon.com"
  subject_alternative_names = ["angular.nemozon.com"]
  route53_zone_id = var.route53_zones_ids["nemozon-com"].hostedzone_id
  local-tags = var.local-tags
}


output "angular-nemozon-com" {
  value = module.angular-nemozon-com
}