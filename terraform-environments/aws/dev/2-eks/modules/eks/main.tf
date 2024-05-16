
#Create kubernetes cluster
module "eks-base-cluster" {
  source               = "./eks-base-cluster"

  PRI_SUB_A_ID         = var.VPC_LIST["vpc-1-base"].PRIVATE_SUBNET_A_ID
  PRI_SUB_B_ID         = var.VPC_LIST["vpc-1-base"].PRIVATE_SUBNET_B_ID
  PRI_SUB_C_ID         = var.VPC_LIST["vpc-1-base"].PRIVATE_SUBNET_C_ID
  EKS_CLUSTER_ROLE_ARN = var.IAM.EKS_CLUSTER_ROLE_ARN
  NODE_GROUP_ROLE_ARN  = var.IAM.NODE_GROUP_ROLE_ARN
  EKS_FARGATE_ROLE_ARN = var.IAM.EKS_FARGATE_ROLE_ARN

  PROJECT_NAME         = var.PROJECT_NAME
  CLUSTER_NAME         = "eks-base-cluster"  
  local-tags = var.local-tags
}
