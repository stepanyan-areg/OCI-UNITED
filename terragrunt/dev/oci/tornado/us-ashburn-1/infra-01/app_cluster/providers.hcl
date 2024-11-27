locals {
  kubernetes_provider = strcontains(basename(get_terragrunt_dir()), "engines") || strcontains(basename(get_terragrunt_dir()), "system_charts") || strcontains(basename(get_terragrunt_dir()), "observability")
  github_provider     = strcontains(basename(get_terragrunt_dir()), "engines")
  github_token        = get_env("TF_VAR_github_token", "none")
}

generate "providers" {
  path      = "providers.tf"
  if_exists = "overwrite"
  contents  = <<EOF
provider "helm" {
  kubernetes {
    host = "${dependency.oke.outputs.cluster_endpoints.public_endpoint}"
    cluster_ca_certificate = <<CA_CERT
${dependency.oke.outputs.cluster_ca_cert}
CA_CERT

    exec {
      api_version = "client.authentication.k8s.io/v1beta1"
      command     = "oci"
      args        = ["ce", "cluster", "generate-token", "--cluster-id", "${dependency.oke.outputs.oke_cluster_id}", "--region", "${dependency.oke.outputs.region}"]
    }
  }
}

provider "kubectl" {
  host = "${dependency.oke.outputs.cluster_endpoints.public_endpoint}"
  cluster_ca_certificate = <<CA_CERT
${dependency.oke.outputs.cluster_ca_cert}
CA_CERT
  load_config_file  = false
  apply_retry_count = 5

  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    command     = "oci"
    args        = ["ce", "cluster", "generate-token", "--cluster-id", "${dependency.oke.outputs.oke_cluster_id}", "--region", "${dependency.oke.outputs.region}"]
  }
}

%{ if local.kubernetes_provider ~}
provider "kubernetes" {
  host = "${dependency.oke.outputs.cluster_endpoints.public_endpoint}"
  cluster_ca_certificate = <<CA_CERT
${dependency.oke.outputs.cluster_ca_cert}
CA_CERT

  experiments {
    manifest_resource = true
  }

  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    command     = "oci"
    args        = ["ce", "cluster", "generate-token", "--cluster-id", "${dependency.oke.outputs.oke_cluster_id}", "--region", "${dependency.oke.outputs.region}"]
  }
}
%{ endif ~}

EOF
}
