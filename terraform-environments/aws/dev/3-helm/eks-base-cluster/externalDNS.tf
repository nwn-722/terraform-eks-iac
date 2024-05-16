

resource "helm_release" "external-DNS-controller" {
  name = "external-dns-controller"

  repository = "https://kubernetes-sigs.github.io/external-dns"
  chart      = "external-dns"
  namespace  = "kube-system"
  version    = "1.14.3"

  set {
    name  = "serviceAccount.name"
    value = "external-dns"
  }

  set {
    name  = "serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn"
    value = var.external_dns_irsa_role_arn
  }

  set {
    name  = "policy"
    value = "sync"
  }
}


output "external-dns-controller" {
  value =  {
      name = helm_release.external-DNS-controller.chart
      status = helm_release.external-DNS-controller.status
  }
}