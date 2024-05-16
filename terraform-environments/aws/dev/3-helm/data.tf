# ##############################################################################
# # DATA SOURCES
# ##############################################################################

data "aws_caller_identity" "current" {}


data "terraform_remote_state" "eks" {
  backend = "remote"

  config = {
    organization = "nemozon"
    workspaces = {
      name = "dev-2-eks"
    }
  }
}



# output "eks_cluster_name" {
#   value = data.terraform_remote_state.eks.outputs.eks["eks-clusters"]["eks-base-cluster"].EKS_CLUSTER_NAME
# }
