locals{
  my_org_conf         = read_terragrunt_config(find_in_parent_folders("org.hcl"))
  kubernetes_provider = strcontains(basename(get_terragrunt_dir()), "engines") || strcontains(basename(get_terragrunt_dir()), "system_charts") || strcontains(basename(get_terragrunt_dir()), "observability")
  github_provider     = strcontains(basename(get_terragrunt_dir()), "engines")
  github_token        = get_env("TF_VAR_github_token", "none")
}

generate "providers" {
  path      = "providers.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
provider "helm" {
  kubernetes {
    host                   = "${dependency.oke.outputs.cluster_endpoint}"
    cluster_ca_certificate = "${dependency.oke.outputs.cluster_ca_cert}"
    
    exec {
      api_version = "client.authentication.k8s.io/v1beta1"
      command     = "oci"
      args        = ["ce", "cluster", "generate-token", "--cluster-id", "${dependency.oke.outputs.cluster_id}", "--region", "${dependency.oke.outputs.deployed_to_region}"]
    }
  }
}

provider "kubectl" {
  host                   = "${dependency.oke.outputs.cluster_endpoint}"
  cluster_ca_certificate = "${dependency.oke.outputs.cluster_ca_cert}"
  load_config_file       = false
  apply_retry_count      = 5
    
    exec {
      api_version = "client.authentication.k8s.io/v1beta1"
      command     = "oci"
      args        = ["ce", "cluster", "generate-token", "--cluster-id", "${dependency.oke.outputs.cluster_id}", "--region", "${dependency.oke.outputs.deployed_to_region}"]
    }
}

%{ if local.kubernetes_provider ~}
provider "kubernetes" {
  host                   = "${dependency.oke.outputs.cluster_endpoint}"
  cluster_ca_certificate = "${dependency.oke.outputs.cluster_ca_cert}"
  experiments {
    manifest_resource = true
  }
    
    exec {
      api_version = "client.authentication.k8s.io/v1beta1"
      command     = "oci"
      args        = ["ce", "cluster", "generate-token", "--cluster-id", "${dependency.oke.outputs.cluster_id}", "--region", "${dependency.oke.outputs.deployed_to_region}"]
    }
}
%{ endif ~}

%{ if local.github_provider ~}
provider "github" {
  owner = "${local.my_org_conf.locals.github_org_name}"
%{ if local.github_token != "none" ~}
  token = "${local.github_token}"
%{ endif ~}
}
%{ endif ~}
  EOF
}