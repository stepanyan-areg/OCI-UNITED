variable "keda_namespace" {
  default = "keda"
  type    = string
}

variable "chart_name" {
  default = "keda"
  type    = string
}

variable "repository" {
  default     = "https://kedacore.github.io/charts"
  description = "Keda Chart Repository"
}

variable "chart_version" {
  default     = "2.15"
  description = "The Keda helm chart version"
}

variable "has_dedicated_infra_nodes" {
  type        = bool
  default     = false
  description = "If enabled, components will be deployed on dedicated nodes with label role:infra"
}
