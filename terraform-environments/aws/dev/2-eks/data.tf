# #############################################################################
# # DATA SOURCES
# #############################################################################

data "aws_caller_identity" "current" {}

data "terraform_remote_state" "core_infrastructure" {
  backend = "remote"

  config = {
    organization = "nemozon"
    workspaces = {
      name = "dev-1-core-infrastructure"
    }
  }
}

# output "console_output" {
#   value = data.terraform_remote_state.core_infrastructure.outputs.vpc["vpc-1-base"].PUBLIC_SUBNET_A_ID
# }