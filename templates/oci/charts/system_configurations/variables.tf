variable "tenancy_ocid" {}
variable "compartment_ocid" {}
variable "region" {}
variable "user_ocid" {
  default = ""
}
variable "fingerprint" {
  default = ""
}
variable "private_key_path" {
  default = ""
}
variable "home_region" {
  default = ""
}

variable "cluster_name" {
  description = "The name of the cluster"
  type        = string

}
variable "cert_manager_issuer_staging_mode" {
  description = "Whether to create a staging issuer for cert-manager"
  type        = bool
  default     = false
}

variable "cert_manager_issuer_production_mode" {
  description = "Whether to create a production issuer for cert-manager"
  type        = bool
  default     = false
}

variable "issuer_email" {
  description = "The email to use for the cert-manager issuer - Just for getting notification if renewal fails"
  type        = string
  default     = ""

}

variable "ingress_class_name" {
  description = "The name of the ingress class to use for the cert-manager issuer"
  type        = string
  default     = "kong"

}