resource "aws_eks_addon" "coredns" {
  cluster_name                = var.EKS_CLUSTER_NAME
  addon_name                  = "coredns"
  addon_version               = "v1.11.1-eksbuild.6"
  resolve_conflicts_on_create = "OVERWRITE"

  configuration_values = jsonencode({
    replicaCount = 2
    resources = {
      limits = {
        cpu    = "100m"
        memory = "150Mi"
      }
      requests = {
        cpu    = "100m"
        memory = "150Mi"
      }
    }
  })
}