output "EKS_CLUSTER_NAME" {
    value = aws_eks_cluster.eks-cluster.name
}

output "eks-cluster-version" {
    value = aws_eks_cluster.eks-cluster.version
}

output "endpoint" {
  value = aws_eks_cluster.eks-cluster.endpoint
}

output "kubeconfig-certificate-authority-data" {
  value = aws_eks_cluster.eks-cluster.certificate_authority[0].data
}

output "node-groups" {
    value = module.NODE_GROUP
}

output "fargate-profiles" {
    value = module.FARGATE_PROFILE
}

output "oidc" {
    value = module.oidc
}

output "aws_load_balancer_controller_role_arn" {
    value = module.oidc.aws_load_balancer_controller_role_arn
}

output "external_dns_irsa_role_arn" {
    value = module.oidc.external_dns_irsa_role_arn
}

