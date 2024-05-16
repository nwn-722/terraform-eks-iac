data "aws_iam_policy_document" "external_dns_updates_policy_document" {
  statement {
    effect    = "Allow"
    actions   = ["route53:ChangeResourceRecordSets"]
    resources = ["arn:aws:route53:::hostedzone/*"]
  }

  statement {
    effect    = "Allow"
    actions   = [
      "route53:ListHostedZones",
      "route53:ListResourceRecordSets",
      "route53:ListTagsForResource"
    ]
    resources = ["*"]
  }
}


data "aws_iam_policy_document" "external_dns_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]
    effect  = "Allow"

    condition {
      test     = "StringEquals"
      variable = "${replace(aws_iam_openid_connect_provider.eks.url, "https://", "")}:sub"
      values   = ["system:serviceaccount:kube-system:external-dns"]
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

resource "aws_iam_policy" "AllowExternalDNSUpdates" {
  name   = "${var.clusterName}-AllowExternalDNSUpdates"
  policy = data.aws_iam_policy_document.external_dns_updates_policy_document.json
}


resource "aws_iam_role" "external-dns-irsa-role" {
  assume_role_policy = data.aws_iam_policy_document.external_dns_assume_role_policy.json
  name               = "${var.clusterName}-external-dns-irsa-role"

  tags = merge(
    var.local-tags
  )
}


resource "aws_iam_role_policy_attachment" "external_dns_attach" {
  role       = aws_iam_role.external-dns-irsa-role.name
  policy_arn = aws_iam_policy.AllowExternalDNSUpdates.arn
}


#outputs
output "external_dns_irsa_role_arn" {
  value = aws_iam_role.external-dns-irsa-role.arn
}
