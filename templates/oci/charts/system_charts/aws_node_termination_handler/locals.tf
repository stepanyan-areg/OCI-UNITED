locals {
  base_values = templatefile("${path.module}/values.yaml", {
    cluster_name              = var.cluster_name
    sa_name                   = var.serviceaccount
    release_name              = var.name
    has_dedicated_infra_nodes = var.has_dedicated_infra_nodes
  })
}
