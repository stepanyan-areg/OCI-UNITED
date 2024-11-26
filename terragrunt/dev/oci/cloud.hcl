locals {
  # Pull in account and region details
  my_account_conf   = read_terragrunt_config(find_in_parent_folders("account.hcl"))
  my_region_conf    = read_terragrunt_config(find_in_parent_folders("region.hcl"))

  # Generate the state bucket name
  state_bucket_name = "test-${local.my_account_conf.locals.my_account}-tf-state"
}

generate "oci_provider" {
  path      = "oci_provider.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
provider "oci" {
  region              = "${local.my_region_conf.locals.my_region}"
  private_key_path    = "${local.my_account_conf.locals.private_key_path}"
  config_file_profile = "${local.my_account_conf.locals.config_file_profile}"
  tenancy_ocid        = "${local.my_account_conf.locals.tenancy_ocid}"
  user_ocid           = "${local.my_account_conf.locals.user_ocid}"
  fingerprint         = "${local.my_account_conf.locals.fingerprint}"
  private_key         = "${local.my_account_conf.locals.private_key_path}"
}
provider "oci" {
  alias               = "home"
  region              = "${local.my_region_conf.locals.my_region}"
  private_key_path    = "${local.my_account_conf.locals.private_key_path}"
  tenancy_ocid        = "${local.my_account_conf.locals.tenancy_ocid}"
  user_ocid           = "${local.my_account_conf.locals.user_ocid}"
  fingerprint         = "${local.my_account_conf.locals.fingerprint}"
  private_key         = "${local.my_account_conf.locals.private_key_path}"
  config_file_profile = "${local.my_account_conf.locals.config_file_profile}"
}

EOF
}


# (Terraform version >= 1.6.4)
generate "backend" {
  path      = "backend.tf"
  if_exists = "overwrite"
  contents = <<EOF
terraform {
  backend "s3" {
    bucket                      = "terraform-states"
    key                         = "${path_relative_to_include()}/terraform.tfstate"
    region                      = "us-ashburn-1"
    skip_region_validation      = true
    skip_credentials_validation = true
    skip_requesting_account_id  = true
    use_path_style              = true
    skip_s3_checksum            = true
    skip_metadata_api_check     = true
    endpoints = {
      s3 = "https://idjckklxqqfq.compat.objectstorage.us-ashburn-1.oraclecloud.com"
    }
  }
}
EOF
}
