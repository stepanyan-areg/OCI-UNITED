output "oke_cluster_id" {
  value = module.oke.cluster_id
}
output "cluster_endpoints" {
  value = module.oke.cluster_endpoints
}
output "control_plane_subnet_cidr" {
  value = module.oke.control_plane_subnet_cidr
}
output "vcn_id" {
  value = module.oke.vcn_id
}
output "worker_pools" {
  value = module.oke.worker_pools
}
output "worker_instances" {
  value = module.oke.worker_instances
}
output "cluster_name" {
  description = "Name of the OKE cluster"
  value       = var.cluster_name
}
output "region" {
  description = "The region used for the infrastructure"
  value       = var.region
}
output "cluster_ca_cert" {
  value     = local.cluster_ca_cert
  sensitive = true
}
output "cluster_kubeconfig" {
  value = data.oci_containerengine_cluster_kube_config.kubeconfig.content
}