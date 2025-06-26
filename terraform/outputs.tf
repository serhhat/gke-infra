output "gke_cluster_name" {
  value = google_container_cluster.primary.name
}

output "gke_cluster_location" {
  value = google_container_cluster.primary.location
}

output "gke_project_id" {
  value = var.project_id
}

output "get_credentials_command" {
  value = "gcloud container clusters get-credentials ${google_container_cluster.primary.name} --region ${google_container_cluster.primary.location} --project ${var.project_id}"
}

output "istio_ingress_static_ip" {
  description = "Static IP reserved for Istio Ingress Gateway"
  value       = google_compute_address.istio_ingress_ip.address
}