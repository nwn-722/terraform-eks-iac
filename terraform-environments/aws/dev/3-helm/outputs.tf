output "Caller" {
  description = "Caller Identity"
  value       = data.aws_caller_identity.current
}


output "eks-base-cluster-charts" {
  value = module.eks-base-cluster
}
