variable "EKS_CLUSTER_NAME" {}

variable "local-tags" {
  type = map(string)
}

variable "aws_load_balancer_controller_role_arn" {}
variable "external_dns_irsa_role_arn" {}