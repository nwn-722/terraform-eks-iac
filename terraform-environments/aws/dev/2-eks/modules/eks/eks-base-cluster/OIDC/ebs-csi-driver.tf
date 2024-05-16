
data "aws_iam_policy_document" "aws-ebs-csi-driver-trust-policy" {
  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]
    effect  = "Allow"

    condition {
      test     = "StringEquals"
      variable = "${replace(aws_iam_openid_connect_provider.eks.url, "https://", "")}:sub"
      values   = ["system:serviceaccount:kube-system:ebs-csi-controller-sa"]
    }

    condition {
      test     = "StringEquals"
      variable = "${replace(aws_iam_openid_connect_provider.eks.url, "https://", "")}:aud"
      values   = ["sts.amazonaws.com"]
    }

    principals {
      identifiers = [aws_iam_openid_connect_provider.eks.arn]
      type        = "Federated"
    }
  }
}

# resource "aws_iam_policy" "AllowExternalDNSUpdates" {
#   name   = "${var.clusterName}-AllowExternalDNSUpdates"
#   policy = data.aws_iam_policy_document.external_dns_updates_policy_document.json
# }


resource "aws_iam_role" "AmazonEKS_EBS_CSI_DriverRole" {
  assume_role_policy = data.aws_iam_policy_document.aws-ebs-csi-driver-trust-policy.json
  name               = "${var.clusterName}-AmazonEKS_EBS_CSI_DriverRole"

  tags = merge(
    var.local-tags
  )
}


resource "aws_iam_role_policy_attachment" "ebs-csi-policy-attach" {
  role       = aws_iam_role.AmazonEKS_EBS_CSI_DriverRole.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy"
}


#outputs
output "AmazonEKS_EBS_CSI_DriverRole_arn" {
  value = aws_iam_role.AmazonEKS_EBS_CSI_DriverRole.arn
}
