terraform {
  source = "${get_repo_root()}/templates/oci/charts/system_charts"
}

# For Inputs
include "root" {
  path   = find_in_parent_folders()
  expose = true
}

# For AWS provider & tfstate S3 backand
include "cloud" {
  path = find_in_parent_folders("cloud.hcl")
}

# For Helm, Kubectl & GitHub providers
include "common_providers" {
  path = find_in_parent_folders("providers.hcl")
}

dependency "oke" {
  config_path  = "../010_oke"
  mock_outputs = {
    cluster_endpoint       = "https://mock-cluster-endpoint:6443"
    cluster_ca_cert        = "mock-ca-certificate"
    cluster_id             = "mock-cluster-id"
  }
  mock_outputs_merge_strategy_with_state = "deep_map_only"
  mock_outputs_allowed_terraform_commands = ["init", "validate"]
}

locals {
  my_account_conf      = read_terragrunt_config(find_in_parent_folders("account.hcl"))
  my_env               = include.root.locals.my_env_conf.locals.my_env
  my_stack             = include.root.locals.my_stack_conf.locals.my_stack
  cluster_name         = "oke-${local.my_env}"
  my_region            = include.root.locals.my_region_conf.locals.my_region
  compartment_id       = include.root.locals.my_account_conf.locals.compartment_id
  tenancy_ocid         = include.root.locals.my_account_conf.locals.tenancy_ocid
}

inputs = {
  cluster_endpoint       = dependency.oke.outputs.cluster_endpoints
  cluster_ca_cert        = dependency.oke.outputs.cluster_ca_cert
  cluster_id             = dependency.oke.outputs.oke_cluster_id
  region                 = local.my_region
  compartment_id         = local.compartment_id
  compartment_ocid       = local.compartment_id
  worker_compartment_id  = local.compartment_id
  tenancy_ocid           = local.tenancy_ocid
  tenancy_id             = local.tenancy_ocid 

  # Nginx Ingress Contorller
  ingress_nginx_enabled                       = true
  ingress_nginx_namespace                     = "nginx-ingress"
  ingress_nginx_chart_version                 = "4.11.2"
  #Cert-Manager
  cert_manager_enabled  = true  
  cert_manager_namespace = "cert-manager"
  cert_manager_helm_chart_version = "v1.15.3"
  # issuer_email = aregstepanyan1@gmail.com
  ingress_email_issuer  = "aregstepanyan1@gmail.com"
  ingress_hosts         = "ags-it.lol"
  ingress_nginx_enabled = true
  ingress_tls           = true
  ingress_cluster_issuer = "letsencrypt-prod"
  #Keda
  keda_enabled                                 = true
  keda_namespace                               = "keda"

}

