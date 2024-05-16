variable "PROJECT_NAME" {}

variable "local-tags" {
  type = map(string)
}

variable "VPC_LIST" {
  type = any
}

variable "IAM" {
  type = any
}
