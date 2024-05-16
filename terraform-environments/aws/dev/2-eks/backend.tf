locals {
  aws_region       = "us-east-2"
  environment_name = "dev"
  project-name     = var.PROJECT_NAME
  tags = {
    ops_env              = "${local.environment_name}"
    ops_managed_by       = "terraform cloud",
    ops_source_repo      = "git@github.com:nemozon-com/nemozon-tf-iac.git",
    ops_source_repo_path = "terraform-environments/aws/${local.environment_name}/2-eks",
    ops_owners           = "DevOps",
    version           = "v1.0.0"
  }
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 3.37.0"
    }

    http = {
      source  = "hashicorp/http"
      version = "3.4.1"
    }
  }


  backend "remote" {
    ## Update to your Terraform Cloud organization
    organization = "nemozon"

    workspaces {
      name = "dev-2-eks"
    }
  }
}


provider "aws" {
  region = local.aws_region
}

provider "http" {
}
