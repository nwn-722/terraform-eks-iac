resource "aws_eks_addon" "aws-ebs-csi-driver" {
  cluster_name                = var.EKS_CLUSTER_NAME
  addon_name                  = "aws-ebs-csi-driver"
  addon_version               = "v1.28.0-eksbuild.1"
  resolve_conflicts_on_create = "OVERWRITE"
  service_account_role_arn = var.oidc.AmazonEKS_EBS_CSI_DriverRole_arn
}

