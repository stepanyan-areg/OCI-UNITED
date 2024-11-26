# terraform {
#   source = "git::https://github.com/oracle-terraform-modules/terraform-oci-vcn.git//?ref=v3.6.0"
# }
terraform {
  source = "${get_repo_root()}/templates/oci/vcn"
}

include "root" {
  path   = find_in_parent_folders()
  expose = true
}

include "cloud" {
  path = find_in_parent_folders("cloud.hcl")
}

locals {
  my_env         = include.root.locals.my_env_conf.locals.my_env
  my_region      = include.root.locals.my_region_conf.locals.my_region
  my_account     = include.root.locals.my_account_conf.locals.my_account
  compartment_id = include.root.locals.my_account_conf.locals.compartment_id
  tenancy_id     = include.root.locals.my_account_conf.locals.tenancy_ocid
}

inputs = {
  # VCN Configuration  
  vcn_name                = "${local.my_account}-vcn"
  compartment_id          = local.compartment_id  
  tenancy_id              = local.tenancy_id
  vcn_cidrs               = ["10.0.0.0/16"]
  vcn_dns_label           = "vcnmodule"
  enable_ipv6             = false
  label_prefix            = local.my_env
  create_service_gateway  = false
  attached_drg_id         = null # If applicable, add the DRG OCID here
  freeform_tags           = {
    environment = "dev"
  }
  # Internet Gateway Configuration
  create_internet_gateway       = true  
  internet_gateway_display_name = "internet-gateway"

  # nat_gateway Configuration
  create_nat_gateway       = true 
  nat_gateway_display_name = "nat-gateway"  

  #Subnets
  subnets = {
    # Availability Domain 1
    sub1 = {
      name                  = "public-subnet-ad1"
      cidr_block            = "10.0.1.0/24"
      type                  = "public"
      availability_domain   = 0
    }
    sub2 = {
      name                  = "private-subnet-ad1"
      cidr_block            = "10.0.2.0/24"
      type                  = "private"
      availability_domain   = 0
    }

    # Availability Domain 2
    sub3 = {
      name                  = "public-subnet-ad2"
      cidr_block            = "10.0.3.0/24"
      type                  = "public"
      availability_domain   = 1
    }
    sub4 = {
      name                  = "private-subnet-ad2"
      cidr_block            = "10.0.4.0/24"
      type                  = "private"
      availability_domain   = 1
    }

    # Availability Domain 3
    sub5 = {
      name                  = "public-subnet-ad3"
      cidr_block            = "10.0.5.0/24"
      type                  = "public"
      availability_domain   = 2
    }
    sub6 = {
      name                  = "private-subnet-ad3"
      cidr_block            = "10.0.6.0/24"
      type                  = "private"
      availability_domain   = 2
    }
  }

}
