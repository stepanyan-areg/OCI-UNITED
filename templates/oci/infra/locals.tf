locals {
  kubeconfig_map    = yamldecode(data.oci_containerengine_cluster_kube_config.kubeconfig.content)
  cluster_ca_cert   = base64decode(local.kubeconfig_map.clusters[0].cluster["certificate-authority-data"])
}