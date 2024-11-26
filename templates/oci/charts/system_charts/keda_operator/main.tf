resource "helm_release" "keda" {
  namespace        = var.keda_namespace
  name             = var.chart_name
  chart            = var.chart_name
  repository       = var.repository
  version          = var.chart_version
  create_namespace = true
  values           = [local.base_values]
}