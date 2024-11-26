# # OCI Provider
# provider "oci" {
#   tenancy_ocid = var.tenancy_ocid
#   region       = var.region
# }

# provider "oci" {
#   alias        = "home_region"
#   tenancy_ocid = var.tenancy_ocid
#   region       = var.region
#   user_ocid        = var.user_ocid
#   fingerprint      = var.fingerprint
#   private_key_path = var.private_key_path
# }

# # Kubernetes Provider for interacting with the OKE cluster
# provider "kubernetes" {
#   host                   = var.cluster_endpoint
#   cluster_ca_certificate = var.cluster_ca_certificate
#   exec {
#     api_version = "client.authentication.k8s.io/v1beta1"
#     args        = ["ce", "cluster", "generate-token", "--cluster-id", var.cluster_id, "--region", var.region]
#     command     = "oci"
#   }
# }

# provider "helm" {
#   kubernetes {
#     host                   = var.cluster_endpoint
#     cluster_ca_certificate = var.cluster_ca_certificate
#     exec {
#       api_version = "client.authentication.k8s.io/v1beta1"
#       args        = ["ce", "cluster", "generate-token", "--cluster-id", var.cluster_id, "--region", var.region]
#       command     = "oci"
#     }
#   }
# }


# # Local variables for cluster access (ensure these are set up in your `local` block)
# # locals {
# #   cluster_endpoint = (var.cluster_endpoint_visibility == "Private") ? (
# #     "https://${module.oke.orm_private_endpoint_oke_api_ip_address}:6443") : (
# #   yamldecode(module.oke.kubeconfig)["clusters"][0]["cluster"]["server"])
# #   external_private_endpoint = (var.cluster_endpoint_visibility == "Private") ? true : false
# #   cluster_ca_certificate    = base64decode(yamldecode(module.oke.kubeconfig)["clusters"][0]["cluster"]["certificate-authority-data"])
# #   cluster_id                = yamldecode(module.oke.kubeconfig)["users"][0]["user"]["exec"]["args"][4]
# #   cluster_region            = yamldecode(module.oke.kubeconfig)["users"][0]["user"]["exec"]["args"][6]
# # }
