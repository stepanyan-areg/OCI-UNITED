locals {
  base_values = templatefile("${path.module}/values.yaml", {
    region                    = var.region
    sa_name                   = var.serviceaccount
    irsa_role                 = module.external_secrets_irsa_role.iam_role_arn
    release_name              = var.name
    has_dedicated_infra_nodes = var.has_dedicated_infra_nodes
  })
}
