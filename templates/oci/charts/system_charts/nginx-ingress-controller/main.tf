# Ingress-NGINX helm chart
## https://kubernetes.github.io/ingress-nginx/
## https://artifacthub.io/packages/helm/ingress-nginx/ingress-nginx
resource "helm_release" "ingress_nginx" {
  name       = "ingress-nginx"
  repository = var.chart_repository
  chart      = "ingress-nginx"
  version    = var.chart_version
  create_namespace = var.namespace == "kube-system" ? false : true
  namespace  = var.namespace
  wait       = true
  values           = [local.base_values]


  set {
    name  = "controller.metrics.enabled"
    value = true
  }
  set {
    name  = "controller.service.annotations.service\\.beta\\.kubernetes\\.io/oci-load-balancer-shape"
    value = var.ingress_load_balancer_shape
    type  = "string"
  }
  set {
    name  = "controller.service.annotations.service\\.beta\\.kubernetes\\.io/oci-load-balancer-shape-flex-min"
    value = var.ingress_load_balancer_shape_flex_min
    type  = "string"
  }
  set {
    name  = "controller.service.annotations.service\\.beta\\.kubernetes\\.io/oci-load-balancer-shape-flex-max"
    value = var.ingress_load_balancer_shape_flex_max
    type  = "string"
  }

}