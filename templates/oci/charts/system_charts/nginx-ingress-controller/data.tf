# ## Kubernetes Service: ingress-nginx-controller
# data "kubernetes_service" "ingress" {
#   metadata {
#     name      = "ingress-nginx-controller"
#     namespace = kubernetes_namespace.cluster_tools.0.id
#   }
#   depends_on = [helm_release.ingress_nginx]

#   count = var.ingress_nginx_enabled ? 1 : 0
# }