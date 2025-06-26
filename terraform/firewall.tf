resource "google_compute_firewall" "allow_http_https_ingress" {
  name    = "allow-istio-ingress"
  project = var.project_id
  network = google_compute_network.vpc.name

  description = "Allow HTTP (80) and HTTPS (443) traffic to GKE nodes for Istio Ingress Gateway"

  direction     = "INGRESS"
  source_ranges = ["0.0.0.0/0"] 

  allow {
    protocol = "tcp"
    ports    = ["80", "443"]
  }

  target_tags = ["gke-node", "main-pool", "application-pool"]
}
