locals {
  base_values = file("${path.module}/values.yaml") 
  # ingress_controller_load_balancer_ip     = var.ingress_nginx_enabled ? data.kubernetes_service.ingress.0.status.0.load_balancer.0.ingress.0.ip : "#Ingress_Controller_Not_Deployed"
  # ingress_controller_load_balancer_ip_hex = var.ingress_nginx_enabled ? join("", formatlist("%02x", split(".", data.kubernetes_service.ingress.0.status.0.load_balancer.0.ingress.0.ip))) : "#Ingress_Controller_Not_Deployed"
  # # ingress_controller_load_balancer_hostname = var.ingress_nginx_enabled ? (data.kubernetes_service.ingress.0.status.0.load_balancer.0.ingress.0.hostname == "" ?
  # # (var.ingress_hosts_include_nip_io ? local.app_nip_io_domain : local.ingress_controller_load_balancer_ip) : data.kubernetes_service.ingress.0.status.0.load_balancer.0.ingress.0.hostname) : "#Ingress_Controller_Not_Deployed"
  # ingress_controller_load_balancer_hostname = var.ingress_nginx_enabled ? (
  # var.ingress_hosts != "" ? local.ingress_hosts[0] : (var.ingress_hosts_include_nip_io ? local.app_nip_io_domain : local.ingress_controller_load_balancer_ip)) : "#Ingress_Controller_Not_Deployed"

  # ingress_nginx_annotations_basic = {
  #   "nginx.ingress.kubernetes.io/rewrite-target" = "/$2"
  # }
  # ingress_nginx_annotations_tls = {
  #   "nginx.ingress.kubernetes.io/ssl-redirect" = "true"
  # }
  # ingress_nginx_annotations_cert_manager = {
  #   "cert-manager.io/cluster-issuer"      = var.ingress_cluster_issuer
  #   "cert-manager.io/acme-challenge-type" = "http01"
  # }
  # ingress_nginx_annotations = merge(local.ingress_nginx_annotations_basic,
  #   var.ingress_tls ? local.ingress_nginx_annotations_tls : {},
  #   (var.ingress_tls && var.cert_manager_enabled) ? local.ingress_nginx_annotations_cert_manager : {}
  # )
  # ingress_hosts     = compact(concat(split(",", var.ingress_hosts), [local.app_nip_io_domain]))
  # app_name          = var.oci_tag_values.freeformTags.AppName
  # app_name_for_dns  = substr(lower(replace(local.app_name, "/\\W|_|\\s/", "")), 0, 6)
  # app_nip_io_domain = (var.ingress_nginx_enabled && var.ingress_hosts_include_nip_io) ? format("${local.app_name_for_dns}.%s.${var.nip_io_domain}", local.ingress_controller_load_balancer_ip_hex) : ""
}