output "Caller" {
  description = "Caller Identity"
  value       = data.aws_caller_identity.current
}

output "vpc" {
  description = "output of VPC module"
  value       = module.vpc
}


output "route53" {
  description = "output of route53 module"
  value       = module.route53
}


output "certificateManager" {
  value = module.certificateManager
}



