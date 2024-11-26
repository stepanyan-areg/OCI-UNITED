## Nginx ingress controller
variable "ingress_nginx_enabled" {
  description = "Whether to install Nginx Ingress Controller"
  type        = bool
  default     = false
}
variable "ingress_nginx_chart_version" {
  description = "The version of nginx_ingress_controller"
  type        = string
  default     = "4.11.2"
}
variable "ingress_nginx_namespace" {
  type    = string
  default = "ingress-nginx"
}
//Cert Manager
variable "cert_manager_enabled" {
  description = "Whether to install cert-manager"
  type        = bool
  default     = false
}

variable "cert_manager_namespace" {
  description = "The namespace to install cert-manager"
  type        = string
  default     = "cert-manager"
}

variable "cert_manager_helm_chart_version" {
  description = "The chart version to install cert-manager"
  type        = string
  default     = "v1.11.0"
}

variable "cert_manager_issuer_email" {
  description = "The email to use for the cert-manager issuer"
  type        = string
  default     = ""
}
variable "ingress_email_issuer" {
  default     = "no-reply@example.cloud"
  description = "You must replace this email address with your own. The certificate provider will use this to contact you about expiring certificates, and issues related to your account."
}
