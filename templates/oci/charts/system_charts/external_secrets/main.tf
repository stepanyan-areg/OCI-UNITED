module "external_secrets_irsa_role" {
  source                                = "terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks"
  version                               = "5.10.0"
  create_role                           = true
  role_name_prefix                      = var.serviceaccount
  attach_external_secrets_policy        = true
  external_secrets_ssm_parameter_arns   = var.ssm_parameter_arns
  external_secrets_secrets_manager_arns = var.secrets_manager_arns

  oidc_providers = {
    ex = {
      provider_arn               = var.cluster_oidc_provider
      namespace_service_accounts = ["${var.namespace}:${var.serviceaccount}"]
    }
  }
}

resource "helm_release" "external_secrets" {
  name             = var.name
  chart            = "external-secrets"
  repository       = "https://charts.external-secrets.io"
  create_namespace = var.namespace == "kube-system" ? false : true
  version          = var.chart_version
  namespace        = var.namespace
  timeout          = var.timeout
  values           = [local.base_values]

  depends_on = [module.external_secrets_irsa_role]
}

