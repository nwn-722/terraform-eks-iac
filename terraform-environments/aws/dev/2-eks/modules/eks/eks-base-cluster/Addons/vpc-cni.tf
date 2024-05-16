resource "aws_eks_addon" "vpc-cni" {
  cluster_name = var.EKS_CLUSTER_NAME
  addon_name   = "vpc-cni"
  addon_version               = "v1.16.3-eksbuild.2"
  resolve_conflicts_on_create = "OVERWRITE"

}


