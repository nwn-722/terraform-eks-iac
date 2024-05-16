

module "vpc" {
  source       = "./modules/vpc"
  PROJECT_NAME = var.PROJECT_NAME
  local-tags   = local.tags
}


module "route53" {
  source       = "./modules/route53"
  PROJECT_NAME = var.PROJECT_NAME
  local-tags   = local.tags
}


module "certificateManager" {
  source            = "./modules/certificates"
  local-tags        = local.tags
  route53_zones_ids = module.route53.hostedzonesIDs
}

