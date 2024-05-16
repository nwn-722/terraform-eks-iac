# terraform-eks-iac

Welcome to the terraform-eks-iac repository, your Terraform-based Infrastructure as Code (IaC) solution for managing AWS resources. This repository is designed to work seamlessly with Terraform Cloud, maintaining the remote state and providing the necessary credentials to access your AWS cloud environment. The structure of this repository is organized into structured folders to ensure easy maintenance.

## Repository Structure

```plaintext
terraform-eks-iac/
└── terraform-environments/
    └── aws/
        ├── dev/
        │   ├── 1-core-infrastructure/
        │   ├── 2-eks/
        │   └── 3-helm/
        ├── prod/2
        └── staging/


```

The repository contains three main folders (`dev`, `prod`, and `staging`), each representing a different environment. Within each environment, there are specific folders (`1-core-infrastructure`, `2-eks`, `3-helm`) that contain the IaC code for the corresponding Terraform workspaces. For example, the `dev` environment contains three Terraform workspaces:

- `1-core-infrastructure`: Responsible for maintaining account-level common infrastructures.
- `2-eks`: Dedicated to managing the EKS implementation. The nested structure protects the generic nature of this source, allowing it to handle future implementations as the business grows.
- `3-helm`: Configures additional controllers for the EKS cluster.


# Usage

To add future resources to this template, use the development branch. When you create a pull request to the master branch, it will automatically trigger a Terraform plan against each updated workspace, showing the result. If there are no errors and you are satisfied with the changes, you can merge the modified code with the master branch. This will create a Terraform apply for the respective workspaces, applying the modifications to the AWS cloud.