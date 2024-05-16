

variable "EKS_CLUSTER_NAME" {}

variable "EKS_FARGATE_ROLE_ARN" {}

variable "PRI_SUB_A_ID" {}
variable "PRI_SUB_B_ID" {}
variable "PRI_SUB_C_ID" {}
   
variable "local-tags" {
  type = map(string)
}