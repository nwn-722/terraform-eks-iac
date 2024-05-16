module "iam" {
  source       = "./modules/iam"
  PROJECT_NAME = var.PROJECT_NAME
  local-tags   = local.tags
}

module "eks" {
  source       = "./modules/eks"
  PROJECT_NAME = var.PROJECT_NAME
  local-tags   = local.tags
  VPC_LIST     = data.terraform_remote_state.core_infrastructure.outputs.vpc
  IAM          = module.iam
  depends_on = [
    module.iam
  ]
}

