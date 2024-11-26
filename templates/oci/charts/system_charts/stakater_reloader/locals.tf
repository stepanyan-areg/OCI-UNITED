locals {
  base_values = templatefile("${path.module}/values.yaml", {
    has_dedicated_infra_nodes = var.has_dedicated_infra_nodes
  })
}
