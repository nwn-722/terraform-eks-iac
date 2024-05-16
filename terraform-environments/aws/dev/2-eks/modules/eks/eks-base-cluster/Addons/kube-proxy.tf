resource "aws_eks_addon" "kube-proxy" {
  cluster_name                = var.EKS_CLUSTER_NAME
  addon_name                  = "kube-proxy"
  addon_version               = "v1.29.1-eksbuild.2"
  resolve_conflicts_on_create = "OVERWRITE"

  configuration_values = jsonencode({
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