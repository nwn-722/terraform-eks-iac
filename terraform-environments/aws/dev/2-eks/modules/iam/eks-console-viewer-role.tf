data "aws_caller_identity" "current" {}


resource "aws_iam_role" "eks-console-viewer-role" {
  name               = "eks-console-viewer-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "eks.amazonaws.com"
        }
      },
    ]
  })
}

resource "aws_iam_policy" "eks-console-viewer_policy" {
  name   = "eks-console-viewer_policy"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = [
          "eks:ListFargateProfiles",
          "eks:DescribeNodegroup",
          "eks:ListNodegroups",
          "eks:ListUpdates",
          "eks:AccessKubernetesApi",
          "eks:ListAddons",
          "eks:DescribeCluster",
          "eks:DescribeAddonVersions",
          "eks:ListClusters",
          "eks:ListIdentityProviderConfigs",
          "iam:ListRoles",
          "aps:ListScrapers"
        ]
        Resource = "*"
      },
      {
        Effect   = "Allow"
        Action   = "ssm:GetParameter"
        Resource = "arn:aws:ssm:*:${data.aws_caller_identity.current.account_id}:parameter/*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "eks-console-viewer_attachment" {
  role       = aws_iam_role.eks-console-viewer-role.name
  policy_arn = aws_iam_policy.eks-console-viewer_policy.arn
}
