data "aws_ssm_parameter" "eks_ami_release_version" {
  name = "/aws/service/eks/optimized-ami/${var.eks_cluster_version}/amazon-linux-2/recommended/release_version"
}
