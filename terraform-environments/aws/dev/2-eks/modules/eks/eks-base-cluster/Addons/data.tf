
data "aws_eks_cluster" "eksCluster" {
  name = var.EKS_CLUSTER_NAME
}
