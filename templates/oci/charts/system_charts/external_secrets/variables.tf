variable "name" {
  type        = string
  description = "Name of release"
  default     = "external-secrets"
}

variable "namespace" {
  type        = string
  description = "Namespace name to deploy helm release"
  default     = "kube-system"
}

variable "chart_version" {
  type        = string
  description = "Helm chart to release"
  default     = "0.8.7"
}

variable "serviceaccount" {
  type        = string
  description = "Serviceaccount name"
  default     = "external-secrets"
}

variable "cluster_oidc_provider" {
  type        = string
  description = "EKS cluster OIDC provider ARN"
}

variable "ssm_parameter_arns" {
  type        = list(string)
  description = "SSM parameter ARNS"
}

variable "secrets_manager_arns" {
  type        = list(string)
  description = "secrets manager ARNS"
}

variable "region" {
  type        = string
  description = "AWS region where the ASG placed"
}

variable "timeout" {
  type        = number
  description = "Timeout for the helm release"
  default     = 600
}

variable "has_dedicated_infra_nodes" {
  type        = bool
  default     = false
  description = "If enabled, components will be deployed on dedicated nodes with label role:infra"
}
