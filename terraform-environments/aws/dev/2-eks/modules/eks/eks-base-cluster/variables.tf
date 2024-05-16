variable "EKS_CLUSTER_ROLE_ARN" {}

variable "CLUSTER_NAME" {}
variable "PRI_SUB_A_ID" {}
variable "PRI_SUB_B_ID" {}
variable "PRI_SUB_C_ID" {}

variable "PROJECT_NAME" {}

variable "NODE_GROUP_ROLE_ARN" {}
variable "EKS_FARGATE_ROLE_ARN" {}

variable "local-tags" {
  type = map(string)
}
   
   