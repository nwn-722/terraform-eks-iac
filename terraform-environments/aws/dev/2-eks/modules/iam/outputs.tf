output "EKS_CLUSTER_ROLE_ARN" {
  value = aws_iam_role.eks_cluster_role.arn
}

output "NODE_GROUP_ROLE_ARN" {
  value = aws_iam_role.nodes_group_role.arn
}

output "EKS_FARGATE_ROLE_ARN" {
  value = aws_iam_role.eks-fargate-role.arn
}

output "EKS_CONSOLE_VIEWER_ROLE_ARN" {
  value = aws_iam_role.eks-console-viewer-role.arn
}
