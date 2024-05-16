
variable "PROJECT_NAME" {}
variable "VPC_CIDR" {}
variable "PUBLIC_SUBNET_A_CIDR" {}
variable "PUBLIC_SUBNET_B_CIDR" {}
variable "PUBLIC_SUBNET_C_CIDR" {}
variable "PRIVATE_SUBNET_A_CIDR" {}
variable "PRIVATE_SUBNET_B_CIDR" {}
variable "PRIVATE_SUBNET_C_CIDR" {}
variable "local-tags" {
  type = map(string)
}