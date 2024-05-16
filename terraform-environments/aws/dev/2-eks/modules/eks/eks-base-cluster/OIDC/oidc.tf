
data "aws_eks_cluster" "eksCluster" {
  name = var.clusterName
}

data "tls_certificate" "eks" {
  url = data.aws_eks_cluster.eksCluster.identity[0].oidc[0].issuer
}


resource "aws_iam_openid_connect_provider" "eks" {
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = [data.tls_certificate.eks.certificates[0].sha1_fingerprint]
  url             = data.aws_eks_cluster.eksCluster.identity[0].oidc[0].issuer

  tags = merge(
    var.local-tags
  )
}


#ouputs

output "eks_oidc_issuer_url" {
  value = data.aws_eks_cluster.eksCluster.identity[0].oidc[0].issuer
}

