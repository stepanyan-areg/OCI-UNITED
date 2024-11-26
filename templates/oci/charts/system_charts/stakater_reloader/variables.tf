variable "reloader_namespace" {
  default = "reloader"
  type    = string
}

variable "chart_name" {
  default = "reloader"
  type    = string
}

variable "repository" {
  default     = "https://stakater.github.io/stakater-charts"
  description = "Reloader Chart Repository"
}

variable "chart_version" {
  default     = "v1.0.121"
  description = "The Reloader helm chart version"
}

variable "has_dedicated_infra_nodes" {
  type        = bool
  default     = false
  description = "If enabled, components will be deployed on dedicated nodes with label role:infra"
}
