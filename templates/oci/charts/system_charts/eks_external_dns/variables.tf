variable "name" {
  type        = string
  description = "Name of release"
  default     = "external-dns"
}

variable "namespace" {
  type        = string
  description = "Namespace name to deploy helm release"
  default     = "kube-system"
}

variable "chart_version" {
  type        = string
  description = "Helm chart to release"
  default     = "1.13.1"
}

variable "create_role_enabled" {
  type        = bool
  description = "Enable or not chart as a component"
  default     = true
}

variable "extra_values" {
  type        = map(any)
  description = "Extra values in key value format"
  default     = {}
}

variable "serviceaccount" {
  type        = string
  description = "Serviceaccount name"
  default     = "external-dns"
}

variable "region" {
  type        = string
  description = "AWS region where the ASG placed"
}

variable "cluster_name" {
  type        = string
  description = "Name of EKS cluster"
}

variable "cluster_oidc_provider" {
  type        = string
  description = "EKS cluster OIDC provider ARN"
}

variable "domain_name" {
  type        = string
  description = "Roure53 hosted zone name"

}

variable "has_dedicated_infra_nodes" {
  type        = bool
  default     = false
  description = "If enabled, components will be deployed on dedicated nodes with label role:infra"
}

variable "override_irsa_role" {
  type        = string
  description = "Override the default IRSA role for external DNS"
  default     = ""
}
