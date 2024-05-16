variable "EKS_CLUSTER_NAME" {}

variable "local-tags" {
  type = map(string)
}

variable "oidc" {
  type = any
}