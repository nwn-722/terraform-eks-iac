


output "eks-clusters" {
  value = {
    "eks-base-cluster" = module.eks-base-cluster
    }
}