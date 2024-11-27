
data "oci_containerengine_cluster_kube_config" "kubeconfig" {
  cluster_id = module.oke.cluster_id
  endpoint   = "PUBLIC_ENDPOINT" # Replace with "PUBLIC_ENDPOINT" or "PRIVATE_ENDPOINT" as per your setup
  token_version = "2.0.0"      # Use "2.0.0" for the latest version
}
module "oke" {
  source = "oracle-terraform-modules/oke/oci"
  version = "5.1.8"

  providers = {
    oci = oci          # Default provider
    oci.home = oci.home # Aliased provider
  }

  # Basic cluster settings
  create_cluster                    = var.create_cluster
  compartment_id                    = coalesce(var.compartment_id, var.compartment_ocid, var.tenancy_id)
  worker_compartment_id             = coalesce(var.worker_compartment_id, var.compartment_id)
  tenancy_id                        = coalesce(var.tenancy_id, var.tenancy_ocid, "unknown")
  cluster_name                      = var.cluster_name
  kubernetes_version                = var.kubernetes_version
  region                            = var.region
  cluster_type                      = var.cluster_type
  cni_type                          = var.cni_type

  # Identity
  create_iam_resources = true
  create_iam_operator_policy   = "always"


  # VCN settings
  vcn_cidrs                    = var.vcn_cidrs
  vcn_create_internet_gateway  = "auto"
  vcn_create_nat_gateway       = "auto"
  vcn_create_service_gateway   = "always"
  vcn_name                     = var.vcn_name

  # Control Plane
  control_plane_is_public           = var.control_plane_is_public
  control_plane_allowed_cidrs       = var.control_plane_allowed_cidrs
  control_plane_nsg_ids             = var.control_plane_nsg_ids
  assign_public_ip_to_control_plane = var.assign_public_ip_to_control_plane
  
  # Worker nodes configuration
  worker_pools                 = var.worker_pools
  worker_pool_size             = var.worker_pool_size
  worker_pool_mode             = var.worker_pool_mode
  worker_shape                 = var.worker_shape
  worker_is_public             = false
  worker_nsg_ids               = var.worker_nsg_ids
  worker_image_type            = "oke"
  worker_image_os              = var.worker_image_os
  worker_image_os_version      = var.worker_image_os_version
  preferred_load_balancer      = "public"
  worker_preemptible_config    = var.worker_preemptible_config

  # Network security groups (NSGs) and subnets
  subnets = var.subnets
  nsgs    = var.nsgs

  # Bastion configuration
  create_bastion              = var.create_bastion
  bastion_is_public           = var.bastion_is_public
  bastion_allowed_cidrs       = var.bastion_allowed_cidrs
  bastion_shape               = var.bastion_shape
  bastion_nsg_ids             = var.bastion_nsg_ids
  ssh_private_key_path        = var.ssh_private_key_path
  ssh_public_key_path         = var.ssh_public_key_path
  allow_bastion_cluster_access = var.allow_bastion_cluster_access

  # Operator-related configurations
  create_operator                    = true                 # Enable operator creation
  operator_image_os                  = var.operator_image_os
  operator_image_os_version          = var.operator_image_os_version
  operator_shape                     = var.operator_shape
  operator_install_helm              = var.operator_install_helm
  operator_install_kubectl_from_repo = true             # Install kubectl on operator

  # Autoscaler-related configurations
  cluster_autoscaler_install           = var.cluster_autoscaler_install
  cluster_autoscaler_namespace         = var.cluster_autoscaler_namespace
  cluster_autoscaler_helm_values_files = var.cluster_autoscaler_helm_values_files
  cluster_autoscaler_helm_version      = var.cluster_autoscaler_helm_version
  cluster_autoscaler_helm_values       = var.cluster_autoscaler_helm_values

  # Metrics server
  metrics_server_install           = var.metrics_server_install
  metrics_server_namespace         = var.metrics_server_namespace
  metrics_server_helm_version      = var.metrics_server_helm_version
  metrics_server_helm_values_files = var.metrics_server_helm_values_files

  # Optional inputs
  assign_dns                  = true
  worker_node_labels          = var.worker_node_labels
  cluster_dns                 = var.cluster_dns
  
}

