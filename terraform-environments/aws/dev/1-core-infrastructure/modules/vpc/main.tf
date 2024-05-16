# creating VPC
module "vpc-1-base" {
  source                = "./vpc-1-base"
    PROJECT_NAME          = var.PROJECT_NAME
    VPC_CIDR              = "10.0.0.0/16"
    PUBLIC_SUBNET_A_CIDR  = "10.0.0.0/20"
    PUBLIC_SUBNET_B_CIDR  = "10.0.16.0/20"
    PUBLIC_SUBNET_C_CIDR  = "10.0.32.0/20"
    PRIVATE_SUBNET_A_CIDR = "10.0.48.0/20"
    PRIVATE_SUBNET_B_CIDR = "10.0.64.0/20"
    PRIVATE_SUBNET_C_CIDR = "10.0.80.0/20"
    local-tags            = var.local-tags
}







