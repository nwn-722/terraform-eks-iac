
module "nemozon-com" {
  source = "./nemozon.com"

  PROJECT_NAME = var.PROJECT_NAME
  local-tags = var.local-tags
}
