terraform {
  source = "${get_repo_root()}/templates/oci/infra"
}


include "root" {
  path   = find_in_parent_folders()
  expose = true
}

include "cloud" {
  path = find_in_parent_folders("cloud.hcl")
}

locals {
  my_account_conf      = read_terragrunt_config(find_in_parent_folders("account.hcl"))
  my_env               = include.root.locals.my_env_conf.locals.my_env
  my_stack             = include.root.locals.my_stack_conf.locals.my_stack
  cluster_name         = "oke-${local.my_env}"
  vcn_name             = "vcn-${local.my_env}"
  my_region            = include.root.locals.my_region_conf.locals.my_region
  compartment_id       = include.root.locals.my_account_conf.locals.compartment_id
  tenancy_ocid         = include.root.locals.my_account_conf.locals.tenancy_ocid
  fingerprint          = include.root.locals.my_account_conf.locals.fingerprint
  user_ocid            = include.root.locals.my_account_conf.locals.user_ocid
  private_key_path     = include.root.locals.my_account_conf.locals.private_key_path
}

inputs = {
  # Basic cluster settings
  create_cluster        = true
  cluster_name          = local.cluster_name
  cluster_type          = "enhanced"
  cni_type              = "flannel"
  kubernetes_version    = "v1.30.1"
  region                = local.my_region

  api_fingerprint       = local.fingerprint
  # user_ocid             = local.user_ocid
  api_private_key_path  = local.private_key_path
  private_key_path      = local.private_key_path
  compartment_id        = local.compartment_id
  # compartment_ocid      = local.compartment_id
  worker_compartment_id = local.compartment_id
  tenancy_ocid          = local.tenancy_ocid
  # tenancy_id            = local.tenancy_ocid  
  current_user_ocid     = local.user_ocid
  # Control Plane
  control_plane_is_public           = true
  control_plane_allowed_cidrs       = ["0.0.0.0/0"]
  control_plane_nsg_ids             = []
  assign_public_ip_to_control_plane = true
  # Worker pool configurations with cluster autoscaler
  worker_pools = {
    np-autoscaled = {
      description              = "Node pool managed by cluster autoscaler",
      size                     = 2,
      min_size                 = 1,
      max_size                 = 3,
      ocpus                    = 2
      autoscale                = true,
      ignore_initial_pool_size = true
    },
    np-autoscaler = {
      description      = "Node pool with cluster autoscaler scheduling allowed",
      size             = 1,
      allow_autoscaler = true,
    },
  }  
# VCN and Network Configuration
  vcn_cidrs                    = ["10.0.0.0/16"]
  vcn_name                     = local.vcn_name
  subnets = {
    bastion  = { create = "auto", newbits = 13 }
    operator = { create = "auto", newbits = 13 }
    cp       = { create = "auto", newbits = 13 }
    int_lb   = { create = "auto", newbits = 11 }
    pub_lb   = { create = "auto", newbits = 11 }
    workers  = { create = "auto", newbits = 4 }
    pods     = { create = "auto", newbits = 2 }
  }  
  # # Network Security Groups (NSGs)
  nsgs = {
    bastion = { create = "auto" }
    cp      = { create = "auto" }
    int_lb  = { create = "auto" }
    operator= { create = "auto" }
    pub_lb  = { create = "auto" }
    pods    = { create = "auto" }
    workers = { create = "auto" }
  }
  # Cluster Autoscaler Configuration
  cluster_autoscaler_install           = true
  cluster_autoscaler_namespace         = "kube-system"
  cluster_autoscaler_helm_values_files = ["${get_terragrunt_dir()}/values/cluster_autoscaler_values.yaml"]
  cluster_autoscaler_helm_version      = "9.24.0" 
  cluster_autoscaler_helm_values       = {}
  # Metrics Server Configuration
  metrics_server_install               = true
  metrics_server_namespace             = "kube-system"  
  metrics_server_helm_version          = "3.8.3"
  metrics_server_helm_values_files     = ["${get_terragrunt_dir()}/values/metric_server_values.yaml"]
  # Bastion Configuration
  create_bastion               = true
  bastion_allowed_cidrs        = ["0.0.0.0/0"]
  ssh_private_key_path         = "/Users/aregstepanyan/.oci/oke_bastion_key"
  ssh_public_key_path          = "/Users/aregstepanyan/.oci/oke_bastion_key.pub"
  allow_bastion_cluster_access = false
  bastion_user                 = "opc"
  bastion_availability_domain  = null           # Defaults to first available
  bastion_image_id             = null           # Ignored when bastion_image_type = "platform"
  bastion_image_os             = "Oracle Linux" # Ignored when bastion_image_type = "custom"
  bastion_image_os_version     = "8"            # Ignored when bastion_image_type = "custom"
  bastion_image_type           = "platform"     # platform/custom
  bastion_nsg_ids              = []             # Combined with created NSG when enabled in var.nsgs
  bastion_public_ip            = null           # Ignored when create_bastion = true
  bastion_upgrade              = false          # true/*false
  bastion_shape = {
    shape            = "VM.Standard.E4.Flex"
    boot_volume_size = 50
    memory           = 4
    ocpus            = 1
  }
  # Operator-related configurations
  create_operator                    = true
  operator_install_helm              = true
  operator_install_kubectl_from_repo = true
  operator_shape = {
    shape            = "VM.Standard.E4.Flex"
    ocpus            = 1
    memory           = 4
    boot_volume_size = 50
  }

  # Node Pools Configuration 
  # worker_pools = {
  #   np1 = {
  #     shape            = "VM.Standard.E3.Flex",
  #     ocpus            = 2,
  #     memory           = 32,
  #     size             = 3,
  #     boot_volume_size = 150,
  #     image_os         = "Oracle Linux",  
  #     image_os_version = "8"      
  #     autoscale              = true     
  #     min_size                        = 1
  #     max_size                        = 5          
  #   }
    # oke-vm-autoscaler = {
    #   size = 1, // Do not scale out. Scale out below worker pool such as oke-vm-optimized.
    #   description      = "Node pool with cluster autoscaler scheduling allowed",
    #   allow_autoscaler = true,
    #   shape = "VM.Standard3.Flex"
    #   ocpus = 1,
    #   memory = 4,
    #   boot_volume_size = 50,
    #   image_os         = "Oracle Linux",  
    #   image_os_version = "8" 
    #   autoscale              = true  
    #   min_size                        = 1
    #   max_size                        = 5          
    # }    
  # }

  # worker_pool_size             = 3
  # worker_pool_mode             = "node-pool"
  # worker_shape                 = { shape = "VM.Standard.E3.Flex", ocpus = 2, memory = 16, boot_volume_size = 50 }
  # worker_is_public             = false
  # worker_nsg_ids               = []
  # preferred_load_balancer      = "public"
  # worker_preemptible_config    = { enable = false, is_preserve_boot_volume = false }

  # Worker Node Configuration
  worker_shape = {
    shape               = "VM.Standard.E4.Flex"
    boot_volume_size    = 50
    boot_volume_vpus_per_gb = 10
    memory              = 16
    ocpus               = 4
    image_os         = "Oracle Linux",  
    image_os_version = "8"     
  }
}