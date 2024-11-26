# Copyright (c) 2022 Oracle and/or its affiliates. All rights reserved.
# Licensed under the Universal Permissive License v 1.0 as shown at http://oss.oracle.com/licenses/upl.
# 

# Cert Manager variables
variable "namespace" {
  default = "cert-manager"
}
variable "chart_repository" {
  default = "https://charts.jetstack.io"
}
variable "chart_version" {
  type        = string
  default     = "v1.15.3"
  description = "Cert Manager Helm chart version."
}
variable "ingress_email_issuer" {
  default     = "no-reply@example.cloud"
  description = "You must replace this email address with your own. The certificate provider will use this to contact you about expiring certificates, and issues related to your account."
}

variable "cert_manager_enabled" {
  default     = true
  description = "Enable x509 Certificate Management"
}