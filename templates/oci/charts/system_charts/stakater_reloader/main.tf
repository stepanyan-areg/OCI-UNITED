resource "helm_release" "reloader" {
  namespace        = var.reloader_namespace
  name             = var.chart_name
  chart            = var.chart_name
  repository       = var.repository
  version          = var.chart_version
  create_namespace = true
  values           = [local.base_values]
}
