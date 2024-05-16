locals {
  aws_region       = "us-east-2"
  environment_name = "dev"
  project-name     = var.PROJECT_NAME
  tags = {
    ops_env              = "${local.environment_name}"
    ops_managed_by       = "terraform cloud",
    ops_source_repo      = "git@github.com:nemozon-com/nemozon-tf-iac.git",
    ops_source_repo_path = "terraform-environments/aws/${local.environment_name}/1-core-infrastructure",
    ops_owners           = "DevOps",
    version           = "v1.0.3"
  }
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 3.37.0"
    }
  }


  backend "remote" {
    # Update to your Terraform Cloud organization
    organization = "nemozon"

    workspaces {
      name = "dev-1-core-infrastructure"
    }
  }
}


provider "aws" {
  region = local.aws_region
}

