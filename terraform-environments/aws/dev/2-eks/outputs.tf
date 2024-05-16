output "Caller" {
  description = "Caller Identity"
  value       = data.aws_caller_identity.current
}

output "iam" {
  description = "output of IAM module"
  value       = module.iam
}

output "eks" {
  description = "output of EKS module"
  value       = module.eks
}
