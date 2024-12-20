# # # Copyright (c) 2023, Oracle and/or its affiliates. All rights reserved.
# # # Licensed under the Universal Permissive License v 1.0 as shown at http://oss.oracle.com/licenses/upl.


# # provider "oci" {
# #   tenancy_ocid = var.tenancy_ocid
# #   region       = var.region
# # }

# # provider "oci" {
# #   alias        = "home"
# #   tenancy_ocid = var.tenancy_ocid
# #   region       = var.region
# #   user_ocid        = var.user_ocid
# #   fingerprint      = var.fingerprint
# #   private_key_path = var.private_key_path
# # }


# # Copyright 2017, 2023 Oracle Corporation and/or affiliates.
# # Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl

# # Provider configurations for resource + home regions w/ some automatically derived values

# # tflint-ignore: terraform_required_providers
# provider "oci" {
#   config_file_profile  = var.config_file_profile
#   fingerprint          = var.api_fingerprint
#   private_key          = local.api_private_key
#   private_key_password = var.api_private_key_password
#   region               = var.region
#   tenancy_ocid         = local.tenancy_id
#   user_ocid            = local.user_id
# }

# # tflint-ignore: terraform_required_providers
# provider "oci" {
#   alias                = "home"
#   config_file_profile  = var.config_file_profile
#   fingerprint          = var.api_fingerprint
#   private_key          = local.api_private_key
#   private_key_password = var.api_private_key_password
#   region               = local.home_region
#   tenancy_ocid         = local.tenancy_id
#   user_ocid            = local.user_id
# }
