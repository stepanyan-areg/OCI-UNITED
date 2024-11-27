locals {
  my_account = basename(get_terragrunt_dir())
  config_file_profile = "DEFAULT"
  compartment_id      = "ocid1.tenancy.oc1..aaaaaaaarjfplnumc6g52h4j3455uanqdvycungxybbxuastx2vw5jt27mdq"  # Corrected by wrapping the OCID in quotes
  tenancy_ocid        = "ocid1.tenancy.oc1..aaaaaaaarjfplnumc6g52h4j3455uanqdvycungxybbxuastx2vw5jt27mdq"
  user_ocid           = "ocid1.user.oc1..aaaaaaaacixjo3mtjxcntqls4cn3onv4dpahflc456p7jhf3o2ikcksvv5iq"
  fingerprint         = "40:bb:4b:32:27:a2:10:a3:33:ba:31:d9:8a:96:4a:6f"
  private_key_path    = "/Users/aregstepanyan/.oci/admin-user2.pem"
}
