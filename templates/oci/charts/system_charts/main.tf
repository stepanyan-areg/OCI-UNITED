module "cert-manager" {
  count                            = var.cert_manager_enabled ? 1 : 0
  source                           = "./certificate_manager"
  # cluster_name                     = var.cluster_name
  namespace                        = var.cert_manager_namespace
  chart_version                    = var.cert_manager_helm_chart_version
  # cert_manager_issuer_staging_mode = var.cert_manager_issuer_staging_mode
  # issuer_email                     = var.cert_manager_issuer_email
  # has_dedicated_infra_nodes        = var.has_dedicated_infra_nodes
  ingress_email_issuer = var.ingress_email_issuer

}
# INGRESS CONTROLLERS
module "nginx-ingress-controller" {
  count                     = var.ingress_nginx_enabled ? 1 : 0
  source                    = "./nginx-ingress-controller"
  namespace                 = var.ingress_nginx_namespace
  chart_version             = var.ingress_nginx_chart_version
}
