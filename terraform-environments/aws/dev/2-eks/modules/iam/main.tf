

resource "aws_iam_role" "eks_cluster_role" {
  name = "${var.PROJECT_NAME}-eks-role"
  assume_role_policy = data.aws_iam_policy_document.eks_assume_role.json

  tags = merge(
    var.local-tags
  )
}

resource "aws_iam_role_policy_attachment" "eks_cluster_role-AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.eks_cluster_role.name
}


# Optionally, enable Security Groups for Pods
# Reference: https://docs.aws.amazon.com/eks/latest/userguide/security-groups-for-pods.html
resource "aws_iam_role_policy_attachment" "eks_cluster_role-AmazonEKSVPCResourceController" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController"
  role       = aws_iam_role.eks_cluster_role.name
}


resource "aws_iam_role" "nodes_group_role" {
  name = "${var.PROJECT_NAME}-nodes_group_role"
  assume_role_policy = data.aws_iam_policy_document.ec2_assume_role.json

    tags = merge(
    var.local-tags
  )
}

resource "aws_iam_role_policy_attachment" "nodes_group_role-AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.nodes_group_role.name
}

resource "aws_iam_role_policy_attachment" "nodes_group_role-AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.nodes_group_role.name
}

resource "aws_iam_role_policy_attachment" "nodes_group_role-AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.nodes_group_role.name
}


resource "aws_iam_role" "eks-fargate-role" {
  name = "${var.PROJECT_NAME}-eks-fargate-role"
  assume_role_policy = data.aws_iam_policy_document.fargate_assume_role.json

    tags = merge(
    var.local-tags
  )
}

resource "aws_iam_role_policy_attachment" "example-AmazonEKSFargatePodExecutionRolePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSFargatePodExecutionRolePolicy"
  role       = aws_iam_role.eks-fargate-role.name
  
}



