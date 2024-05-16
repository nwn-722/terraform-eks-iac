
module "eks-base-cluster" {
  source = "./eks-base-cluster"

  aws_load_balancer_controller_role_arn = data.terraform_remote_state.eks.outputs.eks["eks-clusters"]["eks-base-cluster"].aws_load_balancer_controller_role_arn
  external_dns_irsa_role_arn            = data.terraform_remote_state.eks.outputs.eks["eks-clusters"]["eks-base-cluster"].external_dns_irsa_role_arn
  EKS_CLUSTER_NAME                      = data.terraform_remote_state.eks.outputs.eks["eks-clusters"]["eks-base-cluster"].EKS_CLUSTER_NAME
  local-tags                            = local.tags
}
