resource "aws_eks_node_group" "node-group-on-demand" {
  cluster_name    = var.EKS_CLUSTER_NAME
  node_group_name = "${var.EKS_CLUSTER_NAME}-node-group-on-demand"
  node_role_arn   = var.NODE_GROUP_ROLE_ARN
  release_version = nonsensitive(data.aws_ssm_parameter.eks_ami_release_version.value)
  subnet_ids      = [
    var.PRI_SUB_A_ID,
    var.PRI_SUB_B_ID,
    var.PRI_SUB_C_ID
  ]

  scaling_config {
    desired_size = 0
    max_size     = 1
    min_size     = 0
  }

  update_config {
    max_unavailable = 1
  }

  capacity_type = "ON_DEMAND"
  instance_types = ["t2.micro"]


  # Ensure that IAM Role permissions are created before and deleted after EKS Node Group handling.
  # Otherwise, EKS will not be able to properly delete EC2 Instances and Elastic Network Interfaces.
  depends_on = [
    var.NODE_GROUP_ROLE_ARN
  ]

    # Optional: Allow external changes without Terraform plan difference
  lifecycle {
    ignore_changes = [scaling_config[0].desired_size]
  }

    tags = merge(
    var.local-tags
  )

}


resource "aws_eks_node_group" "node-group-spot" {
  cluster_name    = var.EKS_CLUSTER_NAME
  node_group_name = "${var.EKS_CLUSTER_NAME}-node-group-spot"
  node_role_arn   = var.NODE_GROUP_ROLE_ARN
  release_version = nonsensitive(data.aws_ssm_parameter.eks_ami_release_version.value) 
  subnet_ids      = [
    var.PRI_SUB_A_ID,
    var.PRI_SUB_B_ID,
    var.PRI_SUB_C_ID
  ]

  scaling_config {
    desired_size = 2
    max_size     = 3
    min_size     = 1
  }

  update_config {
    max_unavailable = 1
  }

  capacity_type = "SPOT"
  instance_types = ["t3.medium"]


  # Ensure that IAM Role permissions are created before and deleted after EKS Node Group handling.
  # Otherwise, EKS will not be able to properly delete EC2 Instances and Elastic Network Interfaces.
  depends_on = [
    var.NODE_GROUP_ROLE_ARN
  ]

    # Optional: Allow external changes without Terraform plan difference
  lifecycle {
    ignore_changes = [scaling_config[0].desired_size]
  }

    tags = merge(
    var.local-tags
  )
  
}