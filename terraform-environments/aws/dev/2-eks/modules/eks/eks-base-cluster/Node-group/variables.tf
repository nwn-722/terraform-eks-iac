

variable "EKS_CLUSTER_NAME" {}

variable "NODE_GROUP_ROLE_ARN" {}

variable "PRI_SUB_A_ID" {}
variable "PRI_SUB_B_ID" {}
variable "PRI_SUB_C_ID" {}

variable "eks_cluster_version" {}
   
variable "local-tags" {
  type = map(string)
}