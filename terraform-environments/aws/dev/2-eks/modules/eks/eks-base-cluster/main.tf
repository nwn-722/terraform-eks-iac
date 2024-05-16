resource "aws_eks_cluster" "eks-cluster" {
  name     = "${var.PROJECT_NAME}-${var.CLUSTER_NAME}" 
  role_arn = var.EKS_CLUSTER_ROLE_ARN
  version = "1.29"
  vpc_config {
    subnet_ids = [
      var.PRI_SUB_A_ID,
      var.PRI_SUB_B_ID,
      var.PRI_SUB_C_ID
    ]
  }

  # Ensure that IAM Role permissions are created before and deleted after EKS Cluster handling.
  # Otherwise, EKS will not be able to properly delete EKS managed EC2 infrastructure such as Security Groups.
  depends_on = [
    var.EKS_CLUSTER_ROLE_ARN
  ]

  tags = merge(
    var.local-tags
  )
}



# Create node group
module "NODE_GROUP" {
  source           = "./Node-group"
  EKS_CLUSTER_NAME = aws_eks_cluster.eks-cluster.name
  NODE_GROUP_ROLE_ARN = var.NODE_GROUP_ROLE_ARN
  PRI_SUB_A_ID = var.PRI_SUB_A_ID
  PRI_SUB_B_ID = var.PRI_SUB_B_ID
  PRI_SUB_C_ID = var.PRI_SUB_C_ID
  local-tags= var.local-tags
  eks_cluster_version = aws_eks_cluster.eks-cluster.version
}


# Create node group
module "FARGATE_PROFILE" {
  source           = "./FARGATE_PROFILE"
  EKS_CLUSTER_NAME = aws_eks_cluster.eks-cluster.name
  EKS_FARGATE_ROLE_ARN = var.EKS_FARGATE_ROLE_ARN
  PRI_SUB_A_ID = var.PRI_SUB_A_ID
  PRI_SUB_B_ID = var.PRI_SUB_B_ID
  PRI_SUB_C_ID = var.PRI_SUB_C_ID
  local-tags= var.local-tags
}



# OIDC
module "oidc" {
  source = "./OIDC"
  clusterName = aws_eks_cluster.eks-cluster.name
  local-tags= var.local-tags
  depends_on = [
    aws_eks_cluster.eks-cluster
  ]
}

# Addons
module "Addons" {
  source           = "./Addons"
  EKS_CLUSTER_NAME = aws_eks_cluster.eks-cluster.name
  local-tags= var.local-tags
  oidc = module.oidc
  depends_on = [
    module.NODE_GROUP
    ]
}



