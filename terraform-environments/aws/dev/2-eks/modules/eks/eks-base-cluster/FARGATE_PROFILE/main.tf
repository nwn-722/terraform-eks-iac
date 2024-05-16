resource "aws_eks_fargate_profile" "fargate_profile" {

  cluster_name    = var.EKS_CLUSTER_NAME
  fargate_profile_name   = "${var.EKS_CLUSTER_NAME}-fargate-profile"
  pod_execution_role_arn = var.EKS_FARGATE_ROLE_ARN
  subnet_ids             = [
    var.PRI_SUB_A_ID,
    var.PRI_SUB_B_ID,
    var.PRI_SUB_C_ID
  ]

  selector {
    namespace = "default"
    labels = {
      fargate = "yes"
    }
  }

    tags = merge(
    var.local-tags
  )
  
}